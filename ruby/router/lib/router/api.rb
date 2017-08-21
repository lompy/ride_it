module Router
  class API
    def self.parse_params(params)
      origin_lat, origin_long = params['origin'].split(',')
      destination_lat, destination_long = params['destination'].split(',')
      [
        MapPoint.new(lat: origin_lat, long: origin_long),
        MapPoint.new(lat: destination_lat, long: destination_long)
      ]
    end

    def initialize(router)
      @router = router
    end

    def route(params)
      origin, destination = self.class.parse_params(params)
      { routes: @router.call(origin, destination).map(&:to_h) }
    end
  end
end
