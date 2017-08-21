module Router
  class Route
    attr_reader :map_points, :distance, :duration

    def initialize(map_points: [], distance: nil, duration: nil)
      @map_points = Array(map_points).map { |mp| MapPoint.new(**mp) }
      unless @map_points.size > 1
        raise ArgumentError,
              "Route should have at least 2 map points, " \
              "#{@map_points.size} given"
      end
      @distance = distance.to_i # in meters
      @duration = duration.to_i # in seconds
    end

    def to_hash
      { map_points: map_points.map(&:to_h), distance: distance, duration: duration }
    end
    alias :to_h :to_hash

    def ==(other)
      map_points == other.map_points &&
        distance == other.distance && duration == other.duration
    end
  end
end
