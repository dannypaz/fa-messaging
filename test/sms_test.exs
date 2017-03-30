defmodule FutureAdvisorMessagingSmsTest do
  use ExUnit.Case

  @test_numbers ['5551231234', '5552231234']
  @test_message "Test"

  test "send_to_numbers returns an error when message is blank" do
    test_data = {@test_numbers, ""}
    {status, message} = FutureAdvisorMessaging.Sms.send_to_numbers(test_data)
    assert status == :error
    assert message != ""
  end

  test "send_to_numbers returns an error when no phone numbers are provided" do
    test_data = {[], @test_message}
    {status, message} = FutureAdvisorMessaging.Sms.send_to_numbers(test_data)
    assert status == :error
    assert message != ""
  end
end
