require 'spec_helper'

describe GeoNamesAPI::GeoPlace do

  let(:point) { GeoNamesAPI::GeoPlace.new(2593110) }  

  {
    'children' => GeoNamesAPI::Endpoint::Children,
    'hierarchy' => GeoNamesAPI::Endpoint::Hierarchy
  }.each do |test_method, test_class|
    describe "##{test_method}" do
      it "should find #{test_method}" do
        result = point.send(test_method.to_sym)
        result.should be_kind_of(test_class)
        result.geonames.size.should > 0
      end
    end
  end
end