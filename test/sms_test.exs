defmodule FutureAdvisorMessagingSmsTest do
  use ExUnit.Case

  # import Mock

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

  test "send_to_numbers returns a successful response" do
    # test_data = {@test_numbers, @test_message}
    #
    # with_mocks([
    #   {Enum, [], [map: fn(_, _, _) -> true end]},
    #   {Enum, [], [reduce: fn(_, _, _) -> 0 end]},
    # ]) do
    #   {status, res} = FutureAdvisorMessaging.Sms.send_to_numbers(test_data)
    #   {total_sent, sms_total} = res
    #   assert status == :ok
    #   assert total_sent == 0
    #   assert sms_total == 2
    # end
  end
end
