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
      group = store[latitude_index(coords)][longitude_index(coords)]
      group.match(coords)
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
