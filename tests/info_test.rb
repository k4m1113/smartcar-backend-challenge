module InfoTest
  def info_setup
    get "/vehicles/#{@vehicle.id}"
    @info = JSON.parse last_response.body
  end

  def test_info_json_schema
    error_msg = "info should return valid JSON matching its schema"
    info_setup
    schema = Info.schema
    assert last_response.ok?
    assert JSON::Validator.validate(schema, @info), msg = error_msg
  end

  def test_correct_gm_api_hit
    error_msg = "vehicle show endpoint should hit GM /getVehicleInfoService endpoint"
    expected_response = GMApiCall.new(@vehicle.id, 'vehicle_info', nil).call
    api_response = @vehicle.api_response('vehicle_info')
    assert_equal expected_response, api_response, msg = error_msg
  end

  def test_car_electric_or_gas
    error_msg = "drivetrain should be of type 'v8' or 'electric'"
    info_setup
    vehicle_types = ['v8', 'electric']
    assert last_response.ok?
    assert_includes vehicle_types, @info['driveTrain'], msg = error_msg
  end
end
