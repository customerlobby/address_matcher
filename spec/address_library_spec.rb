require 'spec_helper'

describe AddressLibrary do
  include Locations

  it 'geocodes an address' do
    allow(Geocoder).to receive(:search).and_call_original

    AddressLibrary.new.add_address(met_opera_short.address)

    expect(Geocoder).to(
      have_received(:search).with(met_opera_short.address)
    )
  end

  it 'adds address to an AddressGroup indexed by lat-long to 3 digit precision' do
    lib = AddressLibrary.new.add_address(met_opera_short.address)

    group = lib.near(met_opera_short.coords)

    expect(group).to be_an_instance_of AddressGroup
    expect(group[met_opera_short.coords]).to(
      eq met_opera_short.address
    )
  end

  it 'adds multiple nearby addresses to the same AddressGroup' do
    lib = AddressLibrary.new
                        .add_address(met_art_avenue.address)
                        .add_address(met_next_door.address)

    group = lib.near(met_art_avenue.coords)

    expect(group[met_art_avenue.coords]).to(
      eq met_art_avenue.address
    )
    expect(group[met_next_door.coords]).to(
      eq met_next_door.address
    )
  end

  it 'adds multiple far-apart addresses to different AddressGroups' do
    lib = AddressLibrary.new
                        .add_address(met_art_avenue.address)
                        .add_address(met_opera_short.address)

    group_1 = lib.near(met_art_avenue.coords)
    group_2 = lib.near(met_opera_short.coords)

    expect(group_1[met_art_avenue.coords]).to(
      eq met_art_avenue.address
    )
    expect(group_2[met_art_avenue.coords]).to be_nil
    expect(group_1[met_opera_short.coords]).to be_nil
    expect(group_2[met_opera_short.coords]).to(
      eq met_opera_short.address
    )
  end

  it 'adds an array of addresses' do
    addresses = [met_opera_short.address,
                 met_art_ave.address,
                 apartments_1001.address,
                 met_next_door.address
                ]

    lib = AddressLibrary.build(addresses)

    group_1 = lib.near(met_art_ave.coords)
    group_2 = lib.near(met_opera_short.coords)
    group_3 = lib.near(apartments_1001.coords)

    expect(group_1[met_art_ave.coords]).to(
      eq met_art_ave.address
    )
    expect(group_1[met_next_door.coords]).to(
      eq met_next_door.address
    )
    expect(group_2[met_opera_short.coords]).to(
      eq met_opera_short.address
    )
    expect(group_3[apartments_1001.coords]).to(
      eq apartments_1001.address
    )
  end

  describe '#near' do
    it 'returns the address group indexed at the 3-digit precision for a given set of coordinates' do
    lib = AddressLibrary.new
                        .add_address(met_art_avenue.address)
                        .add_address(met_opera_long.address)

    group_1 = lib.near(met_art_avenue.coords)
    group_2 = lib.near(met_opera_long.coords)

    expect(group_1[met_art_avenue.coords]).to(
      eq met_art_avenue.address
    )
    expect(group_1[met_opera_long.coords]).to be_nil
    expect(group_2[met_art_avenue.coords]).to be_nil
    expect(group_2[met_opera_long.coords]).to(
      eq met_opera_long.address
    )
    end
  end

  describe '#match' do
    it 'returns the address which most nearly matches the given address' do
      addresses = [met_opera_short.address,
                   met_art_ave.address,
                   apartments_1001.address,
                   met_next_door.address
                  ]

      lib = AddressLibrary.build(addresses)

      match_1 = lib.match(met_art_avenue.address)
      match_2 = lib.match(met_opera_long.address)

      expect(match_1).to eq met_art_ave.address
      expect(match_2).to eq met_opera_short.address
    end
  end
end
