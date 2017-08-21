require 'sinatra'
require './lib/router'

api = Router::API.new(Router.build(cache: true))
get '/route' do
  content_type :json
  api.route(params).to_json
end
