module GeoNamesAPI
  class GeoPoint
    attr_accessor :lat, :lng, :country_code_abbr

    def initialize(lat, lng)
      @lat = lat
      @lng = lng
    end

    def postalcodes(radius=10,maxRows=1)
      Endpoint::NearbyPostalCode.find_all_by_lat_lng(lat,lng,radius,maxRows)
    end

    def elevation
      Endpoint::Elevation.find(lat,lng)
    end

    def timezone
      Endpoint::TimeZone.find(lat,lng)
    end

    def weather
      Endpoint::Weather.find(lat,lng)
    end

    def wiki
      Endpoint::Wikipedia.find(lat,lng)
    end

    def country_code
      result = Endpoint::CountryCode.find(lat,lng)
      @country_code_abbr = result.country_code
      result
    end

    def country
      Endpoint::Country.find(@country_code_abbr || country_code.country_code)
    end

    def country_subdivisions
      Endpoint::CountrySubdivision.all(lat,lng)
    end

    def places(radius=10, max_rows=10)
      Endpoint::Place.all(lat,lng,radius,max_rows)
    end

    def place_names
      Endpoint::PlaceName.all(lat,lng)
    end

    def streets
      Endpoint::Street.all(lat,lng)
    end
  end
end
