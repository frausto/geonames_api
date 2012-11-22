module GeoNamesAPI
  module Endpoint
    class City < GeoNamesAPI::EndpointObject
      METHOD = "citiesJSON"
      ID = ["north", "south", "east", "west"]
    end
  end
end
