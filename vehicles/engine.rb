module Engine
  attr_accessor :engine

  def engine(action)
    api_response = api_response('engine', action)
    status = api_response['status'] == 'EXECUTED' ? 'success' : 'error'
    {"status": status}
  end

  def self.schema
    JSON.parse(
      {
        "type": "object",
        "required": ["status"],
        "properties": {
          "status": {
            "type": "string"
          }
        }
      }.to_json
    )
  end

  def self.request_schema
    JSON.parse(
      {
        "type": "object",
        "required": ["action"],
        "properties": {
          "action": {
            "type": "string"
          }
        }
      }.to_json
    )
  end
end
