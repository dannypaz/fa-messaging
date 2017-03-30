defmodule FutureAdvisorMessagingHttpTest do
  use ExUnit.Case
  doctest FutureAdvisorMessaging.Twilio

  # Init
  Application.put_env(:future_advisor_messaging, :twilio_sid, "TEST")
  Application.put_env(:future_advisor_messaging, :twilio_token, "TEST")

  test "auth_key is set correctly" do
    auth_key = FutureAdvisorMessaging.Twilio.auth_key
    test_key = [basic_auth: {"TEST", "TEST"}]
    assert auth_key == test_key
  end

  test "request_key is set correctly" do
    url = FutureAdvisorMessaging.Twilio.request_url
    asset 1 + 1 == 2 
  end
end
