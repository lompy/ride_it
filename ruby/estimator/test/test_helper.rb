require 'minitest/autorun'

ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require_relative '../lib/model.rb'
require_relative '../lib/api.rb'
