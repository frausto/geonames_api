module GeoNamesAPI
  module Endpoint
    class Hierarchy < GeoNamesAPI::EndpointObject
      METHOD = "hierarchyJSON"
      ID = ["geonameId"]
      NESTED = false
    end
  end
end