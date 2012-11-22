module GeoNamesAPI
  class GeoBox
    attr_accessor :north, :south, :east, :west

    def initialize(north, south, east, west)
      @north = north
      @east = east
      @south = south
      @west = west
    end

    def earthquakes
      Endpoint::Earthquake.all(north,south,east,west)
    end

    def cities
      Endpoint::City.all(north,south,east,west)
    end
  end
end