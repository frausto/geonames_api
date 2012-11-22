module GeoNamesAPI
  module Endpoint
    class PlaceName < GeoNamesAPI::EndpointObject
      METHOD = "findNearbyPlaceNameJSON"
      ID = ["lat", "lng", "radius", "maxRows"]
    end
  end
end