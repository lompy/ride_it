require 'sinatra'
require './lib/model'
require './lib/api'

tariff = Model::Tariff.new(
  :business,
  booking: 150_00,
  per_minute: 15_00,
  per_km: 38_00,
  min_fare: 299_00
)
dummy_router = proc do |origin, destination|
  Model::Route.new([origin, destination], distance: 20, duration: 39)
end
api = Api.new([tariff], dummy_router)

get '/estimate' do
  content_type :json
  api.estimate(params).to_json
end

get '/tariffs' do
  content_type :json
  api.tariffs.to_json
end
