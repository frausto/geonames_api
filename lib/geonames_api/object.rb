module GeoNamesAPI
  class Object
        
    def self.find(*names)
      params, n = {}, 0
      self::ID.each { |i| params[i] = names[n]; n+= 1 }
      new(where(params).first)
    end
    
    def self.url(params={})
      GeoNamesAPI.url + self::METHOD + GeoNamesAPI.params.merge(params).to_url
    end

    def initialize(response)
      parse(response)
    end 

    def create_attribute(attribute)
      attr_name = attribute.underscore.to_sym
      self.class.send(:attr_accessor, attr_name) unless respond_to?(attr_name)
      attr_name
    end
    
    def set_default_type(value)
      case value
      when /\A\d+\Z/
        value.to_i
      when /\A\d*\.\d*\Z/
        value.to_f
      else
        value
      end
    end
    
    def parse(response)
      response.each do |key, value|
        attr_name = create_attribute(key)
        value = set_default_type(value)
        send("#{attr_name}=", value)
      end 
    end
     
  end
end