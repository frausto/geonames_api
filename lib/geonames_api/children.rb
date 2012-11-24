module GeoNamesAPI
  class Children < GeoNamesAPI::Object
    METHOD = "childrenJSON"
    ID = ["geonameId"]
    NESTED = false
  end
end