module EnergyTest
  def energy_setup
    get "/vehicles/#{@vehicle.id}/battery"
    JSON.parse last_response.body
  end

  def test_energy_json_schema
    error_msg = "energy should return valid JSON matching its schema"
    energy = energy_setup
    schema = Energy.schema
    assert last_response.ok?
    assert JSON::Validator.validate(schema, energy), msg = error_msg
  end

  def test_correct_gm_api_hit
    error_msg = "fuel and battery endpoints should hit GM /getEnergyService endpoint"
    expected_response = GMApiCall.new(@vehicle.id, 'energy').call
    api_response = @vehicle.api_response('energy')
    assert_equal expected_response, api_response, msg = error_msg
  end

  def test_car_type_against_energy_type
    electric_error_msg = "electric drivetrains should return -1 fuel and integer percent battery"
    fuel_error_msg = "v8 drivetrains should return -1 battery and integer percent fuel"
    battery = energy_setup
    vehicle_type = @vehicle.info['driveTrain']
    assert last_response.ok?
    if vehicle_type == 'electric'
      assert battery['percent'] >= 0, msg = electric_error_msg
    else
      assert_equal battery['percent'], -1, msg = fuel_error_msg
    end
  end
end
