defmodule FutureAdvisorMessagingHttpTest do
  use ExUnit.Case
  doctest FutureAdvisorMessaging.Http

  test "auth_key is set correctly" do
    System.put_env("TWILIO_ACCOUNT_SID", "TEST")
    System.put_env("TWILIO_AUTH_TOKEN", "TEST")
    auth_key = FutureAdvisorMessaging.Http.auth_key
    test_key = [basic_auth: {"TEST", "TEST"}]
    assert auth_key == test_key
  end
end
