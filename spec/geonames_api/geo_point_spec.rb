require 'spec_helper'

describe GeoNamesAPI::GeoPoint do

  let(:point) { GeoNamesAPI::GeoPoint.new("37.451","-122.18") }  

  {
    'postalcodes' => GeoNamesAPI::Endpoint::PostalCode,
    'country_subdivisions' => GeoNamesAPI::Endpoint::CountrySubdivision,
    'places' => GeoNamesAPI::Endpoint::Place,
    'place_names' => GeoNamesAPI::Endpoint::PlaceName,
    'streets' => GeoNamesAPI::Endpoint::Street
  }.each do |test_method, test_class|
    describe "##{test_method}" do
      it "should find multiple #{test_method}" do
        result = point.send(test_method.to_sym)
        result.size.should > 0
        result.each{|r| r.should be_kind_of(test_class) }
      end
    end
  end

  {
    'elevation' => GeoNamesAPI::Endpoint::Elevation,
    'timezone' => GeoNamesAPI::Endpoint::TimeZone,
    'weather' => GeoNamesAPI::Endpoint::Weather,
    'wiki' => GeoNamesAPI::Endpoint::Wikipedia,
    'country_code' => GeoNamesAPI::Endpoint::CountryCode,
    'country' => GeoNamesAPI::Endpoint::Country
  }.each do |test_method, test_class|
    describe "##{test_method}" do
      it "should find #{test_method}" do
        result = point.send(test_method.to_sym)
        result.should be_kind_of(test_class)
      end
    end
  end
end