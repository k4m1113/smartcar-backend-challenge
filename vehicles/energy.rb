require './vehicles/battery_range'
require './vehicles/fuel_range'

module Energy
  include BatteryRange
  include FuelRange

  def self.schema
    JSON.parse(
      {
        "type": "object",
        "required": ["percent"],
        "properties": {
          "percent": {
            "type": "integer"
          }
        }
      }.to_json
    )
  end
end
