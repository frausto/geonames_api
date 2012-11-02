module GeoNamesAPI
  class Weather < GeoNamesAPI::Object
    
    METHOD = "findNearByWeatherJSON"
    ID = ["lat", "lng"]
    
    def geo_names_api_country
      @geo_names_api_country ||= GeoNamesAPI::Country.find(country_code)
    end
    
    def geo_names_api_time_zone
      @geo_names_api_time_zone ||= GeoNamesAPI::TimeZone.find(lat, lng)
    end
    
    def time_zone
      geo_names_api_time_zone.time_zone
    end
        
    def at_local
      t = DateTime.parse(datetime)
      time_zone.local(t.year, t.month, t.day, t.hour, t.minute)
    end
    
    def at_utc
      at_local.utc
    end
    
    def elevation_feet
      elevation * 3.28084 if elevation
    end
    
    def elevation_meters
      elevation if elevation
    end
        
    def convert_c_to_f(temp)
      temp * 9.to_f / 5.to_f + 32
    end

    def temperature_f
      convert_c_to_f(temperature) if temperature
    end
    
    def temperature_c
      temperature if temperature
    end
    
    def dew_point_f
      convert_c_to_f(dew_point) if temperature
    end
    
    def dew_point_c
      dew_point if temperature
    end
    
  end
end