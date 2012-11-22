module GeoNamesAPI
  module Endpoint
    class Children < GeoNamesAPI::EndpointObject
      METHOD = "childrenJSON"
      ID = ["geonameId"]
      NESTED = false
    end
  end
end