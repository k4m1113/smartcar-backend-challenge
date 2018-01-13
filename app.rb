require 'sinatra'
require 'sinatra/json'
require './vehicles/vehicle'

set :show_exceptions, false

def set_vehicle
  Vehicle.new(params['id'])
end

get '/vehicles/:id' do
  @vehicle = set_vehicle
  json @vehicle.info
end

get '/vehicles/:id/doors' do
  @vehicle = set_vehicle
  json Vehicle.new(params['id']).security
end

get '/vehicles/:id/fuel' do
  @vehicle = set_vehicle
  json Vehicle.new(params['id']).fuel_range
end

get '/vehicles/:id/battery' do
  @vehicle = set_vehicle
  json Vehicle.new(params['id']).battery_range
end

post '/vehicles/:id/engine' do
  @vehicle = set_vehicle
  json @vehicle.engine request['action']
end

not_found do
  json error: "Endpoint not supported at this time. Please check URL and try again."
end

error do
  json error: "Bad request. Please check parameters and try again."
end
