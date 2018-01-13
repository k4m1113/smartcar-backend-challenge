module EngineTest
  def engine_setup
    action = ['START', 'STOP'].sample
    post(
      "/vehicles/#{@vehicle.id}/engine",
      body: {
        action: action
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
    JSON.parse last_response.body
  end

  def test_engine_json_schema
    error_msg = "engine should return valid JSON matching its schema"
    engine = engine_setup
    schema = Engine.schema
    assert last_response.ok?
    assert JSON::Validator.validate(schema, engine), msg = error_msg
  end

  def test_correct_gm_api_hit
    error_msg = "start/stop engine endpoint should hit GM /actionEngineService endpoint"
    expected_response = GMApiCall.new(@vehicle.id, 'engine').call
    api_response = @vehicle.api_response('engine')
    assert_equal expected_response, api_response, msg = error_msg
  end

  def test_request_validity
    error_msg = "engine start/stop request should include 'action' parameter in body"
    engine_setup
    request = last_request.params['body']
    schema = Engine.request_schema
    assert JSON::Validator.validate(schema, request), msg = error_msg
  end

  def test_response_validity
    error_msg = "engine start/stop should return status of 'success' or 'error'"
    engine = engine_setup
    valid_returns = ['success', 'error']
    assert last_response.ok?
    assert_includes valid_returns, engine['status'], msg = error_msg
  end
end
