require 'httparty'

class GMApiCall
  include HTTParty
  base_uri 'gmapi.azurewebsites.net'
  headers 'Content-Type' => 'application/json'

  def initialize(id, route, action)
    @id = id
    @route = route
    @action = action
  end

  def mapped_route
    mapper = GMApiCall.action_mapper
    @mapped_route = mapper[@route.to_sym]
    @mapped_route
  end

  def call
    if @route == 'engine'
      stop_go = @action == 'START' ? 'START_VEHICLE' : 'STOP_VEHICLE'
      params = {
        'id': @id,
        'responseType': 'JSON',
        'command': stop_go
      }
      @response = self.class.post(
        mapped_route,
        body: params.to_json
      )['actionResult']
    else
      @params = {
        'id': @id,
        responseType: 'JSON'
      }
      @response = self.class.post(
        mapped_route,
        body: @params.to_json
      )['data']
    end
    @response
  end

  def self.action_mapper
    {
      'vehicle_info': '/getVehicleInfoService',
      'security': '/getSecurityStatusService',
      'energy': '/getEnergyService',
      'engine': '/actionEngineService'
    }
  end
end
