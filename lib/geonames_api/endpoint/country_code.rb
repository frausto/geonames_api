module GeoNamesAPI
  module Endpoint
    class CountryCode < GeoNamesAPI::EndpointObject
      METHOD = "countryCodeJSON"
      ID = ["lat", "lng"]
      NESTED = false
    end
  end
end