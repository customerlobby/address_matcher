Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.add_stub(
  'Lincoln Center for the Performing Arts, 30 Lincoln Center Plaza, New York, NY 10023', [
    { 'latitude'     => 40.772748,
      'longitude'    => -73.98384759999,
      'address'      => '30 Lincoln Center Plaza, New York, NY 10023',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  '30 Lincoln Center Plaza, New York, NY 10023', [
    { 'latitude'     => 40.772748,
      'longitude'    => -73.98384759999,
      'address'      => '30 Lincoln Center Plaza, New York, NY 10023',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  '1000 5th Ave, New York, NY 10028', [
    { 'latitude'     => 40.77916555,
      'longitude'    => -73.9629278,
      'address'      => '1000 5th Ave, New York, NY 10028',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  '1000 5th Avenue, New York, NY 10028', [
    { 'latitude'     => 40.7791655,
      'longitude'    => -73.9629278,
      'address'      => '1000 5th Ave, New York, NY 10028',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  '1001 5th Avenue, New York, NY 10028', [
    { 'latitude'     => 40.7785889,
      'longitude'    => -73.9621559,
      'address'      => '1000 5th Ave, New York, NY 10028',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  '1002 5th Avenue, New York, NY 10028', [
    { 'latitude'     => 40.7785016,
      'longitude'    => -73.9625847,
      'address'      => '1002 5th Ave, New York, NY 10028',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)
