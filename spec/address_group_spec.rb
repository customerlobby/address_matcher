require 'spec_helper'

describe AddressGroup do
  include Locations

  it 'stores addresses keyed by lat/long' do
    address_group = AddressGroup.new
    address_group[symphony_hall.coords] = symphony_hall.address

    expect(address_group[symphony_hall.coords]).to eq symphony_hall.address
  end

  it 'returns the address of an exact lat/long match' do
    address_group = AddressGroup.new
    address_group[symphony_hall.coords] = symphony_hall.address
    address_group[nec.coords] = nec.address

    match = address_group.match(symphony_hall.coords)

    expect(match).to eq symphony_hall.address
  end

  it 'returns the address of the closest lat/long if there is not an exact match' do
    address_group = AddressGroup.new
    address_group[boco.coords] = boco.address
    address_group[nec.coords] = nec.address

    match = address_group.match(symphony_hall.coords)

    expect(match).to eq nec.address
  end
end
