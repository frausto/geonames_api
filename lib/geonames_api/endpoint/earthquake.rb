module GeoNamesAPI
  module Endpoint
    class Earthquake < GeoNamesAPI::EndpointObject
      METHOD = "earthquakesJSON"
      ID = ["north", "east", "south", "west", "date", "minMagnitude", "maxRows"]
    end
  end
end