module GeoNamesAPI
  class PlaceName < GeoNamesAPI::Object
    METHOD = "findNearbyPlaceNameJSON"
    ID = ["lat", "lng", "radius", "maxRows"]
  end
end