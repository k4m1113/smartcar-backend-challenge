module BatteryRange
  attr_accessor :battery_range

  def battery_range
    api_response = api_response('energy')
    result = {}
    battery = api_response['batteryLevel']['value']
    result['percent'] = battery === 'null' ? -1 : battery.to_i
    result
  end
end
