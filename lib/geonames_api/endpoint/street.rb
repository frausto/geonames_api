module GeoNamesAPI
  module Endpoint
    class Street < GeoNamesAPI::EndpointObject
      METHOD = "findNearbyStreetsJSON"
      ID = ["lat", "lng", "radius", "maxRows"]
    end
  end
end