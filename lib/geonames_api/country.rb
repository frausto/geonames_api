module GeoNamesAPI
  class Country

    METHOD = "countryInfoJSON"
        
    def self.all
      JSON.load(open(url).read)["geonames"].collect do |response|
        new.parse(response)
      end
    end
    
    attr_accessor :country_code
    
    def initialize(country_code=nil)
      self.country_code = country_code
    end 

    def find
      parse(JSON.load(open(url).read)["geonames"].first)
      self
    end
    
    def parse(response)
      response.each do |key, value|
        attr_name = key.underscore.to_sym
        self.class.send(:attr_accessor, attr_name) unless respond_to? attr_name
        value = GeoNamesAPI.set_default_type(value)
        send("#{attr_name}=", value)
      end 
      self
    end

    def params
      GeoNamesAPI.params.merge({ country: country_code })
    end
    
    def url
      self.class.url(params)
    end
        
    def self.url(params={})
      params = GeoNamesAPI.params.merge(params)
      GeoNamesAPI::BASE_URL + METHOD + GeoNamesAPI.to_url_params(params)
    end
        
  end
end