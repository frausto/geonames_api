module GeoNamesAPI
  module Endpoint
    class Wikipedia < GeoNamesAPI::EndpointObject
      
      METHOD = "findNearbyWikipediaJSON"
      ID = %W(lat lng)
      
    end
  end
end