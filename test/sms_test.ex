defmodule FutureAdvisorMessagingSmsTest do
  use ExUnit.Case

  test "send_to_numbers returns an error when message is blank" do
    FutureAdvisorMessaging.Sms.send_to_numbers
    assert auth_key == test_key
  end

  test "send_to_numbers returns an error when no phone numbers are provided" do
  end

  test "request_key is set correctly" do
    url = FutureAdvisorMessaging.Twilio.request_url
    asset 1 + 1 == 2
  end
end
