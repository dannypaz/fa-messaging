defmodule FutureAdvisorMessagingHttpTest do
  use ExUnit.Case

  import Mock

  test "log_request returns the logged object" do
    with_mock IO, [inspect: fn(obj) -> obj end] do
      result = FutureAdvisorMessaging.Http.log_request("OK")
      assert result == "OK"
    end
  end

  test "decode_json" do
    with_mock Poison, [decode!: fn(_obj) -> :decoded end] do
      result = FutureAdvisorMessaging.Http.decode_json("TEST_JSON_DATA")
      assert result == :decoded
    end
  end

  test "process_response_body" do
    with_mocks([
      {IO, [], [inspect: fn(_obj) -> true end]},
      {Poison, [], [decode!: fn(_obj) -> %{"response" => "TEST"} end]}
    ]) do
      result = FutureAdvisorMessaging.Http.process_response_body("TEST")
      assert result == %{:response => "TEST"}
    end
  end
end
