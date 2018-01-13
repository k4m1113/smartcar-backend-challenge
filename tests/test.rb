require './app'
require 'json-schema'
require 'minitest/autorun'
require 'rack/test'
require 'sinatra/json'
require './tests/app_test'
require './tests/energy_test'
require './tests/engine_test'
require './tests/info_test'
require './tests/security_test'

class Test < Minitest::Test
  include Rack::Test::Methods
  include EnergyTest
  include EngineTest
  include InfoTest
  include SecurityTest
  include AppTest

  def setup
    @vehicle_1 = Vehicle.new(1234)
    @vehicle_2 = Vehicle.new(1235)
    @vehicle = [@vehicle_1, @vehicle_2].sample
  end

  def app
    Sinatra::Application
  end
end
