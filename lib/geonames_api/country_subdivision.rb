module GeoNamesAPI
  class CountrySubdivision < GeoNamesAPI::Object
    METHOD = "countrySubdivisionJSON"
    ID = ["lat", "lng"]
    NESTED = false
  end
end