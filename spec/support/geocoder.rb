Geocoder.configure(lookup: :test)

module Locations
  DATA_PATH = Pathname.new('spec/data')
  TEST_DATA = YAML.load(File.read(DATA_PATH.join('geocoder_data.yaml')))

  TEST_DATA.each do |location, data|
    define_method location do
      OpenStruct.new(data.merge(coords: [data['latitude'], data['longitude']]))
    end
  end
end

Locations::TEST_DATA.values.each do |location|
  Geocoder::Lookup::Test.add_stub(
    location['address'], [
      { 'latitude'     => location['latitude'],
        'longitude'    => location['longitude'],
        'address'      => location['canonical_address'],
        'state'        => location['state'],
        'state_code'   => location['state_code'],
        'country'      => location['country'],
        'country_code' => location['country_code']
      }
    ]
  )
end
