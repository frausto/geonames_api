module GeoNamesAPI
  class CountryCode < GeoNamesAPI::Object
    METHOD = "countryCodeJSON"
    ID = ["lat", "lng"]
    NESTED = false
  end
end