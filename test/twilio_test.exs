defmodule FutureAdvisorMessagingHttpTest do
  use ExUnit.Case

  # Init
  # Application.put_env(:future_advisor_messaging, :twilio_sid, "TEST")
  # Application.put_env(:future_advisor_messaging, :twilio_token, "TEST")

  test "auth_key is set correctly" do
    {key, key2} = {"TEST", "TEST"}
    auth_key = FutureAdvisorMessaging.Twilio.auth_key(key, key2)
    assert auth_key == [basic_auth: {key, key2}]
  end

  # test "url is set correctly" do
  #   {endpoint, key} = {"ENDPOINT", "TEST"}
  #   url = FutureAdvisorMessaging.Twilio.request_url(endpoint, key)
  #   assert url ==
  # end
end
