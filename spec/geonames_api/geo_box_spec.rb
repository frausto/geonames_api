require 'spec_helper'

describe GeoNamesAPI::GeoBox do

  let(:point) { GeoNamesAPI::GeoBox.new(44.1,-9.9,-22.4,55.2) }  

  {
    'earthquakes' => GeoNamesAPI::Endpoint::Earthquake,
    'cities' => GeoNamesAPI::Endpoint::City
  }.each do |test_method, test_class|
    describe "##{test_method}" do
      it "should find multiple #{test_method}" do
        result = point.send(test_method.to_sym)
        result.size.should > 0
        result.each{|r| r.should be_kind_of(test_class) }
      end
    end
  end
end