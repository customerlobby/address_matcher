class AddressGroup
  def initialize
    @store = {}
  end

  def []=(lat_long, address)
    store[lat_long] = address
  end

  def [](lat_long)
    store[lat_long]
  end

  def match(lat_long)
    if exact = store[lat_long]
      exact
    else
      closest_match(lat_long)
    end
  end

  private
  attr_reader :store

  def closest_match(lat_long)
    closest = store.keys.min do |a, b|
      distance_between(lat_long, a) <=> distance_between(lat_long, b)
    end

    store[closest]
  end

  def distance_between(p1, p2)
    Geocoder::Calculations.distance_between(p1, p2)
  end
end
