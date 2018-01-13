module SecurityTest
  def security_setup
    get "/vehicles/#{@vehicle.id}/doors"
    JSON.parse(last_response.body)
  end

  def test_security_json_schema
    error_msg = "doors should return valid JSON matching security schema"
    security = security_setup
    schema = Security.schema
    assert last_response.ok?
    assert JSON::Validator.validate(schema, security, list: true), msg = error_msg
  end

  def test_number_of_doors
    error_msg = "number of locks should equal number of doors"
    security = security_setup
    vehicle_info = @vehicle.info
    assert last_response.ok?
    assert_equal security.length, vehicle_info['doorCount'], msg = error_msg
  end
end
