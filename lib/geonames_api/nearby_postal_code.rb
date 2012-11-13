module GeoNamesAPI
  class NearbyPostalCode < GeoNamesAPI::Object
    METHOD = "findNearbyPostalCodesJSON"
    ID = ["postalcode", "country", "radius", "maxRows"]
  end
end