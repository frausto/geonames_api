module GeoNamesAPI
  module Endpoint
    class CountrySubdivision < GeoNamesAPI::EndpointObject
      METHOD = "countrySubdivisionJSON"
      ID = ["lat", "lng"]
      NESTED = false
    end
  end
end