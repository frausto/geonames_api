module GeoNamesAPI
  class Earthquake < GeoNamesAPI::Object
    METHOD = "earthquakesJSON"
    ID = ["north", "east", "south", "west", "date", "minMagnitude", "maxRows"]
  end
end