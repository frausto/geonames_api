require 'spec_helper'

describe GeoNamesAPI::Endpoint::PlaceName do
  describe "::find" do
    it "should find one place" do
      result = GeoNamesAPI::Endpoint::PlaceName.find("50.01","10.2")
      result.should be_present
    end
  end

  describe "::all" do
    it "should find maxRow places in 100km radius" do
      result = GeoNamesAPI::Endpoint::PlaceName.all("50.01","10.2","100", "3")
      result.size.should == 3
    end
  end
end