$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'geonames_api'

RSpec.configure do |config|
  config.before(:all) do
    puts "Enter your GeonamesAPI username for running functional specs (press enter to just use default)"
    name = $stdin.gets.chomp
    GeoNamesAPI.username = name if name.present?
  end
end
