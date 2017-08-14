module Model
  # Point on map with lat, long coordinates
  class MapPoint
    attr_reader :lat, :long
    def initialize(lat, long)
      @lat = lat.to_f
      @long = long.to_f
      freeze
    end

    def to_h
      { lat: lat, long: long }
    end
  end
end
