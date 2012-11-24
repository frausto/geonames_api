module GeoNamesAPI
  class Elevation < GeoNamesAPI::Object
    METHOD = "astergdemJSON"
    ID = ["lat", "lng"]
    NESTED = false
  end
end