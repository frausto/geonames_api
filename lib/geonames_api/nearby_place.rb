module GeoNamesAPI
  class NearbyPlace < GeoNamesAPI::Object

    METHOD = "findNearbyJSON"
    ID = ["lat", "lng", "radius", "maxRows"]

  end
end