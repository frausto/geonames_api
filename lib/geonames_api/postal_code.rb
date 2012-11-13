module GeoNamesAPI
  class PostalCode < GeoNamesAPI::Object

    METHOD = "postalCodeLookupJSON"
    ID = ["postalcode", "country"]

    #radius in km
    def nearby_codes(radius=10, maxRows=5)
      NearbyPostalCode.all(postalcode, country_code, radius, maxRows)
    end
  end
end