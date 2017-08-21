require 'sinatra'
require './lib/api'
require 'router'

tariff = Model::Tariff.new(
  :business,
  booking: 150_00,
  per_minute: 15_00,
  per_km: 38_00,
  min_fare: 299_00
)

router = Router.build(adapter: :Self, cache: true)
api = API.new([tariff], router)

set :port, 4568

get '/estimate' do
  content_type :json
  api.estimate(params).to_json
end

get '/tariffs' do
  content_type :json
  api.tariffs.to_json
end
