module GeoNamesAPI
  class EndpointObject
    
    NESTED = true

    class << self
      def find(*names)
        if response = where(name_params(names)).first
          new(response)
        end
      end
      
      def all(*names)
        where(name_params(names)).collect { |response| new(response) if response }.compact
      end
      
      def where(params={})
        response = JSON.load(open(url(params)).read)
        GeoNamesAPI.logger.info "GEONAMES RESPONSE (#{Time.now}): #{response}" if GeoNamesAPI.logger
        case response.keys.first
        when /\Astatus\Z/
          message = response["status"]["message"]
          raise GeoNamesAPI::Error, message[0,1].capitalize + message[1,message.length - 1]
        end
        if self::NESTED
          [response.values].flatten
        else
          [response]
        end
      end
      
      def url(params={})
        endpoint = URI.escape(GeoNamesAPI.url + self::METHOD + params_to_url(GeoNamesAPI.params.merge(params)))
        GeoNamesAPI.logger.info "GEONAMES REQUEST (#{Time.now}): #{endpoint}" if GeoNamesAPI.logger
        endpoint
      end
      
      def name_params(names)
        params, n = {}, 0
        if names.any?
          [self::ID].flatten.each { |i| params[i] = names[n]; n+= 1 }
        end
        params.delete_if{ |k, v| v.blank? }
      end
    end

    def initialize(response)
      parse(response)
    end

    def geo_point
      GeoPoint.new(lat,lng) rescue nil
    end

    def geo_box
      GeoBox.new(north,south,east,west) rescue nil
    end

    def geo_place
      GeoPlace.new(geoname_id) rescue nil
    end

    def parse(response)
      response.each do |key, value|
        attr_name = create_attribute(key)
        value = set_default_type(value)
        send("#{attr_name}=", value)
      end
    end

    def create_attribute(attribute)
      attr_name = attribute.underscore.to_sym
      self.class.send(:attr_accessor, attr_name) unless respond_to?(attr_name)
      attr_name
    end
    
    def set_default_type(value)
      case value
      when /\A-?\d+\Z/
        value.to_i
      when /\A-?\d*\.\d*\Z/
        value.to_f
      else
        value
      end
    end

    private

    def self.params_to_url(params={})
      "?" + params.collect { |key, value| "#{key}=#{value}" }.join("&")
    end  
  end
end