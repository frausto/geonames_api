module GeoNamesAPI
  module Endpoint
    class Elevation < GeoNamesAPI::EndpointObject
      METHOD = "astergdemJSON"
      ID = ["lat", "lng"]
      NESTED = false
    end
  end
end