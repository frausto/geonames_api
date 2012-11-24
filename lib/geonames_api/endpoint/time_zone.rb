module GeoNamesAPI
  module Endpoint
    class TimeZone < GeoNamesAPI::EndpointObject
      
      METHOD = "timezoneJSON"
      ID = ["lat", "lng"]
      NESTED = false
      
      def time_zone
        ActiveSupport::TimeZone.new(timezone_id)
      end

      def common_name
        ActiveSupport::TimeZone::MAPPING.key(timezone_id)
      end
      
      def local(time_type)
        t = DateTime.parse(send(time_type))
        time_zone.local(t.year, t.month, t.day, t.hour, t.minute)
      end
      
      def utc(time_type)
        local(time_type).utc
      end
      
      def method_missing(method, *args)
        case method
        # Provides the local and utc time variant of each time
        # Examples: time_zone.sunrise_local, time_zone.time_utc
        when /\A(.*)_(local|utc)\Z/
          send($2, $1)
        end
      end
      
    end
  end
end