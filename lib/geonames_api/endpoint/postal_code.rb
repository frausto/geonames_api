module GeoNamesAPI
  module Endpoint
    class PostalCode < GeoNamesAPI::EndpointObject

      METHOD = "postalCodeLookupJSON"
      ID = ["postalcode", "country"]

      def nearby_codes(radius=10, maxRows=5)
        NearbyPostalCode.all(postalcode, country_code, radius, maxRows)
      end
    end
  end
end