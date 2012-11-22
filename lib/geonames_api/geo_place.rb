module GeoNamesAPI
  class GeoPlace
    attr_accessor :geonameId

    def initialize(geonameId)
      @geonameId = geonameId
    end

    def children
      Endpoint::Children.find(geonameId)
    end

    def hierarchy
      Endpoint::Hierarchy.find(geonameId)
    end
  end
end