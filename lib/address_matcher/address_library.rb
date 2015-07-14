class AddressLibrary
  def self.build(address_list)
    new.tap do |library|
      address_list.each { |address| library.add_address(address) }
    end
  end

  def initialize
    @store = Hash.new do |outer, o_key|
      outer[o_key] = Hash.new do |inner, i_key|
        inner[i_key] = AddressGroup.new
      end
    end
  end

  def add_address(address_string)
    coords = geocode(address_string)
    if coords
      store[latitude_index(coords)][longitude_index(coords)][coords] = address_string
    end
    self
  end

  def near(coords)
    store[latitude_index(coords)][longitude_index(coords)]
  end

  def match(address_string)
    coords = geocode(address_string)
    if coords
      address_for_coords(coords)
    end
  end

  def address_for_coords(lat_long)
    unless lat_long.to_a.empty?
      group = store[latitude_index(lat_long)][longitude_index(lat_long)]
      group.match(lat_long)
    end
  end

  private
  attr_reader :store

  def geocode(address_string)
    response = Geocoder.search(address_string).first
    if response
      response.coordinates
    end
  end

  def latitude_index(coords)
    coords.first.round(3)
  end

  def longitude_index(coords)
    coords.last.round(3)
  end
end
