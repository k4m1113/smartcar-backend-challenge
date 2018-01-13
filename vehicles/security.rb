module Security
  attr_accessor :security

  def security
    api_response = api_response('security')
    doors = []
    api_response['doors']['values'].each do |door|
      doors << {
        'location': door['location']['value'],
        'locked': door['locked']['value'] == 'True'
      }
    end
    doors
  end

  def self.schema
    JSON.parse(
      {
        "type": "object",
        "required": ["location", "locked"],
        "properties": {
          "location": {
            "type": "string"
          },
          "locked": {
            "type": "boolean"
          }
        }
      }.to_json
    )
  end
end
