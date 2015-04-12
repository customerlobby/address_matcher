require 'spec_helper'

describe AddressLibrary do
  it 'geocodes an address' do
    allow(Geocoder).to receive(:search).and_call_original

    AddressLibrary.new.add_address('30 Lincoln Center Plaza, New York, NY 10023')

    expect(Geocoder).to(
      have_received(:search).with('30 Lincoln Center Plaza, New York, NY 10023')
    )
  end

  it 'adds address to an AddressGroup indexed by lat-long to 3 digit precision' do
    lib = AddressLibrary.new.add_address('30 Lincoln Center Plaza, New York, NY 10023')

    group = lib.near([40.773, -73.984])

    expect(group).to be_an_instance_of AddressGroup
    expect(group[[40.772748, -73.98384759999]]).to(
      eq '30 Lincoln Center Plaza, New York, NY 10023'
    )
  end

  it 'adds multiple nearby addresses to the same AddressGroup' do
    lib = AddressLibrary.new
                        .add_address('1000 5th Avenue, New York, NY 10028')
                        .add_address('1002 5th Avenue, New York, NY 10028')

    group = lib.near([40.779, -73.963])

    expect(group[[40.7791655, -73.9629278]]).to(
      eq '1000 5th Avenue, New York, NY 10028'
    )
    expect(group[[40.7785016, -73.9625847]]).to(
      eq '1002 5th Avenue, New York, NY 10028'
    )
  end

  it 'adds multiple far-apart addresses to different AddressGroups' do
    lib = AddressLibrary.new
                        .add_address('1000 5th Avenue, New York, NY 10028')
                        .add_address('30 Lincoln Center Plaza, New York, NY 10023')

    group_1 = lib.near([40.779, -73.963])
    group_2 = lib.near([40.773, -73.984])

    expect(group_1[[40.7791655, -73.9629278]]).to(
      eq '1000 5th Avenue, New York, NY 10028'
    )
    expect(group_2[[40.7791655, -73.9629278]]).to be_nil
    expect(group_1[[40.772748, -73.98384759999]]).to be_nil
    expect(group_2[[40.772748, -73.98384759999]]).to(
      eq '30 Lincoln Center Plaza, New York, NY 10023'
    )
  end

  it 'adds an array of addresses' do
    addresses = ['30 Lincoln Center Plaza, New York, NY 10023',
                 '1000 5th Ave, New York, NY 10028',
                 '1001 5th Avenue, New York, NY 10028',
                 '1002 5th Avenue, New York, NY 10028'
                ]

    lib = AddressLibrary.build(addresses)

    group_1 = lib.near([40.779, -73.963])
    group_2 = lib.near([40.773, -73.984])
    group_3 = lib.near([40.779, -73.962])

    expect(group_1[[40.77916555, -73.9629278]]).to(
      eq '1000 5th Ave, New York, NY 10028'
    )
    expect(group_1[[40.7785016, -73.9625847]]).to(
      eq '1002 5th Avenue, New York, NY 10028'
    )
    expect(group_2[[40.772748, -73.98384759999]]).to(
      eq '30 Lincoln Center Plaza, New York, NY 10023'
    )
    expect(group_3[[40.7785889, -73.9621559]]).to(
      eq '1001 5th Avenue, New York, NY 10028'
    )
  end

  describe '#near' do
    it 'returns the address group indexed at the 3-digit precision for a given set of coordinates' do
    lib = AddressLibrary.new
                        .add_address('1000 5th Avenue, New York, NY 10028')
                        .add_address('30 Lincoln Center Plaza, New York, NY 10023')

    group_1 = lib.near([40.7791655, -73.9629278])
    group_2 = lib.near([40.772748, -73.98384759999])

    expect(group_1[[40.7791655, -73.9629278]]).to(
      eq '1000 5th Avenue, New York, NY 10028'
    )
    expect(group_2[[40.7791655, -73.9629278]]).to be_nil
    expect(group_1[[40.772748, -73.98384759999]]).to be_nil
    expect(group_2[[40.772748, -73.98384759999]]).to(
      eq '30 Lincoln Center Plaza, New York, NY 10023'
    )
    end
  end

  describe '#match' do
    it 'returns the address which most nearly matches the given address' do
      addresses = ['30 Lincoln Center Plaza, New York, NY 10023',
                  '1000 5th Ave, New York, NY 10028',
                  '1001 5th Avenue, New York, NY 10028',
                  '1002 5th Avenue, New York, NY 10028'
                  ]

      lib = AddressLibrary.build(addresses)

      match = lib.match('1000 5th Avenue, New York, NY 10028')

      expect(match).to eq '1000 5th Ave, New York, NY 10028'
    end
  end
end
