module AppTest
  def test_bad_parameters_error_message
    error_msg = "bad request should return JSON parameter error"
    get '/vehicles/1233'
    response = JSON.parse last_response.body
    expected = JSON.parse({"error": "Bad request. Please check parameters and try again."}.to_json)
    assert !last_response.ok?
    assert_equal expected, response, msg = error_msg
  end

  def test_bad_endpoint_error_message
    error_msg = "bad url should return JSON endpoint error"
    get '/kamille-rules'
    response = JSON.parse last_response.body
    expected = JSON.parse({"error": "Endpoint not supported at this time. Please check URL and try again."}.to_json)
    assert !last_response.ok?
    assert_equal expected, response, msg = error_msg
  end
end
