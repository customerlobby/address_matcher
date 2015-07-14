Gem::Specification.new do |s|
  s.name        = 'address-matcher'
  s.version     = '0.1.1'
  s.date        = '2015-04-07'
  s.summary     = "Matches addresses by geocoding"
  s.description = "Uses geocoding to perform fuzzy match on address strings"
  s.authors     = ["Stuart Terrett"]
  s.email       = 'shterrett@gmail.com'
  s.files       = ["lib/address_matcher.rb"]
  s.homepage    = 'http://github.com/shterrett/address_matcher'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency('geocoder', '~> 1.2')

  s.add_development_dependency('rake', '~> 10.4')
  s.add_development_dependency('rspec', '~> 3.3')
  s.add_development_dependency('simplecov', '~> 0.10')
  s.add_development_dependency('pry', '~> 0.10')
end
