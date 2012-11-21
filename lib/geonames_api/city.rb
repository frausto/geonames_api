module GeoNamesAPI
  class City < GeoNamesAPI::Object
    METHOD = "citiesJSON"
    ID = ["north", "south", "east", "west"]
  end
end
