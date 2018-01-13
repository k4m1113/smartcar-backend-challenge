module Info
  attr_accessor :info

  def info
    @api_response = api_response('vehicle_info')
    @info = {}
    json_builder(@api_response, @info, ['vin', 'color', 'driveTrain'])

    if @api_response['twoDoorCoupe']['value'] == 'True'
      @info['doorCount'] =  2
    elsif @api_response['fourDoorSedan']['value'] == 'True'
      @info['doorCount'] = 4
    else
      @info['doorCount'] = 'unknown'
    end
    @info
  end

  def self.schema
    JSON.parse(
      {
        "type": "object",
        "required": [
          "vin", "color",
          "driveTrain",
          "doorCount"
        ],
        "properties": {
          "vin": {
            "type": "string"
          },
          "color": {
            "type": "string"
          },
          "driveTrain": {
            "type": "string"
          },
          "doorCount": {
            "type": "integer"
          }
        }
      }.to_json
    )
  end
end
