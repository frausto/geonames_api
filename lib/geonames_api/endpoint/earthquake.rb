module GeoNamesAPI
  module Endpoint
    class Earthquake < GeoNamesAPI::EndpointObject
      METHOD = "earthquakesJSON"
      ID = ["north", "south", "east", "west", "date", "minMagnitude", "maxRows"]
    end
  end
end