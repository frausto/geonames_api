require 'spec_helper'

describe GeoNamesAPI::Endpoint::CountrySubdivision do
  describe "::find" do
    it "should find one subdivision" do
      result = GeoNamesAPI::Endpoint::CountrySubdivision.find("50.01","10.2")
      result.should be_present
    end
  end

  describe "::all" do
    it "should find multiple subdivisions" do
      result = GeoNamesAPI::Endpoint::CountrySubdivision.all("50.01","10.2")
      result.size.should > 0
    end
  end
end