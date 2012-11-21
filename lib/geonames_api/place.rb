module GeoNamesAPI
  class Place < GeoNamesAPI::Object

    METHOD = "findNearbyJSON"
    ID = ["lat", "lng", "radius", "maxRows"]

  end
end