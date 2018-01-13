require './vehicles/energy'
require './gm'
require './vehicles/info'
require './vehicles/security'
require './vehicles/engine'

class Vehicle
  include Energy
  include Info
  include Security
  include Engine

  attr_accessor :api_response,
                :id

  def initialize(id)
    @id = id
  end

  def api_response(route, action = nil)
    GMApiCall.new(@id, route, action).call
  end

  def json_builder(object, target_hash, target_keys)
    target_keys.each do |key|
      target_hash[key] = object[key]['value']
    end
  end
end
