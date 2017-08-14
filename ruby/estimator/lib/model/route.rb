module Model
  # Route is a sequence of MapPoint-s with estimated distance and duration
  class Route
    attr_reader :map_points, :distance, :duration
    def initialize(map_points, distance: nil, duration: nil)
      @map_points = Array(map_points)
      @distance = distance.to_i # in meters
      @duration = duration.to_i # in seconds
    end

    def to_h
      { map_points: map_points, distance: distance, duration: duration }
    end
  end
end
