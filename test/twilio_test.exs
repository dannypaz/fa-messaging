defmodule FutureAdvisorMessagingTwilioTest do
  use ExUnit.Case

  import Mock

  test "create" do
  end

  test "generate_form_data" do
    {to, body, msid} = {"5551231234", "Test Message", "MSID"}
    {type, result} = FutureAdvisorMessaging.Twilio.generate_form_data(to, body, msid)

    assert type == :form
    assert result[:To] == to
    assert result[:Body] == body
    assert result[:MessagingServiceSid] == msid
  end

  test "generate_request_url works correctly" do
    {endpoint, key} = {"ENDPOINT", "TEST"}
    url = FutureAdvisorMessaging.Twilio.generate_request_url(endpoint, key)

    assert String.contains?(url, endpoint) == true
    assert String.contains?(url, key) == true
  end

  test "send_request" do
    {url, form, sid, token} = {"URL", "FORMDATA", "SID", "TOKEN"}

    with_mock HTTPoison, [post: fn(_url, _data, _opts, _auth) -> :success end] do
      result = FutureAdvisorMessaging.Twilio.send_request({url, form}, sid, token)
      assert result == :success
    end
  end
end
