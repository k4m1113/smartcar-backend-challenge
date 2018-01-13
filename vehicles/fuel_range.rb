module FuelRange
  attr_accessor :fuel_range

  def fuel_range
    api_response = api_response('energy')
    result = {}
    fuel = api_response['tankLevel']['value']
    result['percent'] = fuel === 'null' ? -1 : fuel.to_i
    result
  end
end
