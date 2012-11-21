require 'spec_helper'

describe GeoNamesAPI::CountrySubdivision do
  describe "find" do
    it "should find one" do
      result = GeoNamesAPI::CountrySubdivision.find("50.01","10.2")
    end
  end
end