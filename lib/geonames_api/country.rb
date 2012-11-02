module GeoNamesAPI
  class Country < GeoNamesAPI::Object

    METHOD = "countryInfoJSON"
    ID = ["country"]
        
    def self.all
      where.collect { |response| new(response) }
    end
        
    def self.where(params={})
      JSON.load(open(url(params)).read)["geonames"]
    end

  end
end