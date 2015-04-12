require 'simplecov'
require 'pry'

SimpleCov.start do
  add_filter 'spec/'
end

# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'geocoder'
require_relative 'support/geocoder'

Dir['./spec/shared/**/*.rb'].sort.each { |f| require f }
require_relative '../lib/address_matcher'

require 'rspec'

RSpec.configure do |config|
  config.order = 'random'
end
