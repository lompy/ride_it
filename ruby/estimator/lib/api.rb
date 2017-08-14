require_relative './model'

# Api encapsulates all endpoints so that later
# we can switch to another routing layer
class Api
  def initialize(tariffs, router)
    @tariffs = Array(tariffs).map { |t| [t.name.to_s, t] }.to_h
    @router = router
  end

  def estimate(params)
    origin = Model::MapPoint.new(*params['origin'].split(','))
    destination = Model::MapPoint.new(*params['destination'].split(','))
    route = @router.call(origin, destination)
    tariff = @tariffs.fetch(params['tariff'] || 'business')
    fare = Model::CalculateFare.call(tariff, route)
    {
      routes: [
        {
          map_points: [origin.to_h, destination.to_h],
          distance: route.distance,
          duration: route.duration,
          fare: Model.format_money(fare)
        }
      ],
      tariff: tariff.name,
      currency: Model::Currency.to_s
    }
  end

  def tariffs
    { tariffs: @tariffs.values.map(&:to_h), currency: Model::Currency }
  end
end
