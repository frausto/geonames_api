module GeoNamesAPI
  class Weather
    METHOD = "findNearByWeatherJSON"
    
    attr_accessor :latitude, :longitude
    
    def initialize(latitude, longitude)
      self.latitude, self.longitude = latitude, longitude
    end
    
    def find
      parse(JSON.load(open(url).read)["weatherObservation"])
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
      GeoNamesAPI.params.merge({ lat: latitude, lng: longitude })
    end
        
    def url
      GeoNamesAPI::BASE_URL + METHOD + GeoNamesAPI.to_url_params(params)
    end

  end
end