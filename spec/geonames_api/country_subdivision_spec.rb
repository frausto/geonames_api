require 'spec_helper'

describe GeoNamesAPI::CountrySubdivision do
  describe "::find" do
    it "should find one subdivision" do
      result = GeoNamesAPI::CountrySubdivision.find("50.01","10.2")
      result.should be_present
    end
  end

  describe "::all" do
    it "should find multiple subdivisions" do
      result = GeoNamesAPI::CountrySubdivision.all("50.01","10.2")
      result.size.should > 0
    end
  end
end