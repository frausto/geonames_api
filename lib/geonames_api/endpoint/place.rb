module GeoNamesAPI
  module Endpoint
    class Place < GeoNamesAPI::EndpointObject

      METHOD = "findNearbyJSON"
      ID = ["lat", "lng", "radius", "maxRows"]

    end
  end
end