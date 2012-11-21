require 'spec_helper'

describe GeoNamesAPI::NearbyPlace do
  describe "::find" do
    it "should find one place" do
      result = GeoNamesAPI::NearbyPlace.find("50.01","10.2")
      result.should be_present
    end
  end

  describe "::all" do
    it "should find multiple places in 100km radius" do
      result = GeoNamesAPI::NearbyPlace.all("50.01","10.2","100")
      result.size.should > 0
    end
  end
end