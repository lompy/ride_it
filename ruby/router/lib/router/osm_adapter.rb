module Router
  class OSMAdapter
    def initialize(endpoint = 'http://127.0.0.1:5000/route/v1/driving/')
      @connection = Faraday.new(url: endpoint)
    end

    def call(origin, destination)
      response = @connection.get("#{to_param(origin)};#{to_param(destination)}")
      JSON.parse(response.body)['routes'].map do |r|
        Route.new(
          # Using map_points from args for now.
          # Don't know how to interpret legs from osm response.
          map_points: [origin, destination],
          distance: r['distance'],
          duration: r['duration']
        )
      end
    end

    private

    def to_param(map_point)
      "#{map_point.long},#{map_point.lat}"
    end
  end
end
