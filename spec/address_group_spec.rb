require 'spec_helper'

describe AddressGroup do
  let(:symphony_hall) do
    { lat_long: [42.3426, -71.0858],
      address: '301 Massachusetts Ave, Boston, MA 02115'
    }
  end

  let(:nec) do
    { lat_long: [42.3406, -71.0869],
      address: '290 Huntington Ave, Boston, MA 02115'
    }
  end

  let(:boco) do
    { lat_long: [42.3462, -71.0901],
      address: '8 Fenway, Boston, MA 02215'
    }
  end


  it 'stores addresses keyed by lat/long' do
    address_group = AddressGroup.new
    address_group[symphony_hall[:lat_long]] = symphony_hall[:address]

    expect(address_group[symphony_hall[:lat_long]]).to eq symphony_hall[:address]
  end

  it 'returns the address of an exact lat/long match' do
    address_group = AddressGroup.new
    address_group[symphony_hall[:lat_long]] = symphony_hall[:address]
    address_group[nec[:lat_long]] = nec[:address]

    match = address_group.match(symphony_hall[:lat_long])

    expect(match).to eq symphony_hall[:address]
  end

  it 'returns the address of the closest lat/long if there is not an exact match' do
    address_group = AddressGroup.new
    address_group[boco[:lat_long]] = boco[:address]
    address_group[nec[:lat_long]] = nec[:address]

    match = address_group.match(symphony_hall[:lat_long])

    expect(match).to eq nec[:address]
  end
end
