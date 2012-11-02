module GeoNamesAPI
  class Weather < GeoNamesAPI::Object
    
    METHOD = "findNearByWeatherJSON"
    ID = ["lat", "lng"]
    
    def self.where(params={})
      JSON.load(open(url(params)).read)["weatherObservation"]
    end
    
    def self.url(params)
      GeoNamesAPI.url + METHOD + GeoNamesAPI.params.merge(params).to_url
    end

    def initialize(response)
      parse(response)
    end
    
  end
end