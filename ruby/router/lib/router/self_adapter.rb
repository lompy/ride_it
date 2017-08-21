module Router
  class SelfAdapter
    def initialize(endpoint = 'http://127.0.0.1:4567/route/')
      @connection = Faraday.new(url: endpoint)
    end

    def call(origin, destination)
      response =
        @connection.get("?origin=#{to_param(origin)}&destination=#{to_param(destination)}")
      JSON.parse(response)['routes'].map { |r| Route.new(**r.deep_symbolize_keys) }
    end

    private

    def to_param(map_point)
      "#{map_point.lat},#{map_point.long}"
    end
  end
end
