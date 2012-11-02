module GeoNamesAPI
  class Object
    
    NESTED = true
        
    def self.find(*names)
      if response = where(name_params(names)).first
        new(response)
      end
    end
    
    def self.all(*names)
      where(name_params(names)).collect { |response| new(response) if response }.compact
    end
    
    def self.where(params={})
      response = JSON.load(open(url(params)).read)
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
    
    def self.url(params={})
      GeoNamesAPI.url + self::METHOD + GeoNamesAPI.params.merge(params).to_url
    end
    
    def self.name_params(names)
      params, n = {}, 0
      if names.any?
        [self::ID].flatten.each { |i| params[i] = names[n]; n+= 1 }
      end
      params
    end

    def initialize(response)
      parse(response)
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
         
  end
end