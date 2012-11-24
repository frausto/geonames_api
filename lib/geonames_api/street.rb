module GeoNamesAPI
  class Street < GeoNamesAPI::Object
    METHOD = "findNearbyStreetsJSON"
    ID = ["lat", "lng", "radius", "maxRows"]
  end
end