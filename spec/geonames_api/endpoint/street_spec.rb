require 'spec_helper'

describe GeoNamesAPI::Endpoint::Street do
  describe "::find" do
    it "should find one Street" do
      result = GeoNamesAPI::Endpoint::Street.find("37.451","-122.18")
      result.should be_present
    end

    it "should not find streets outside of the US" do
      result = GeoNamesAPI::Endpoint::Street.find("50.01","10.2")
      result.should == nil
    end
  end

  describe "::all" do
    it "should find multiple Streets in 100km radius" do
      result = GeoNamesAPI::Endpoint::Street.all("37.451","-122.18","1", "3")
      result.size.should == 3
    end
  end
end