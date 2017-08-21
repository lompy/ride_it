module Router
  class MapPoint
    attr_reader :lat, :long

    def initialize(lat:, long:)
      @lat = lat.to_f
      @long = long.to_f
      freeze
    end

    def to_hash
      { lat: lat, long: long }
    end
    alias :to_h :to_hash

    def ==(other)
      lat == other.lat && long == other.long
    end
  end
end
