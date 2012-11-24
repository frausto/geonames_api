module GeoNamesAPI
  class GeoPlace
    attr_accessor :geoname_id

    def initialize(geoname_id)
      @geoname_id = geoname_id
    end

    def children
      Endpoint::Children.find(geoname_id)
    end

    def hierarchy
      Endpoint::Hierarchy.find(geoname_id)
    end
  end
end