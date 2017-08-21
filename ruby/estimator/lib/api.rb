require_relative './model'
require 'router'

# API encapsulates all endpoints so that later
# we can switch to another routing layer
class API
  def initialize(tariffs, router)
    @tariffs = Array(tariffs).map { |t| [t.name.to_s, t] }.to_h
    @router = router
  end

  def estimate(params)
    origin, destination = Router::API.parse_params(params)
    routes = @router.call(origin, destination)
    tariff = @tariffs.fetch(params['tariff'] || 'business')
    {
      routes: routes.map do |r|
        r.to_h.merge(fare: Model.format_money(Model::CalculateFare.call(tariff, r)))
      end,
      tariff: tariff.name,
      currency: Model::Currency.to_s
    }
  end

  def tariffs
    { tariffs: @tariffs.values.map(&:to_h), currency: Model::Currency }
  end
end
