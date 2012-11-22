module GeoNamesAPI
  module Endpoint
    class Weather < GeoNamesAPI::EndpointObject
      
      METHOD = "findNearByWeatherJSON"
      ID = ["lat", "lng"]

      def location_point
        point = super
        point.country_code_abbr = country_code
        point
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
end