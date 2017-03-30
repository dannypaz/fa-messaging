defmodule FutureAdvisorMessaging.Twilio do
  @twilio_number "+15867899278"

  def create(to, body) do
    {twilio_token, twilio_sid, twilio_msid, twilio_sms_url} = twilio_info()

    IO.puts "HERE"

    {:ok, response} = HTTPoison.post(
      request_url(twilio_sms_url, twilio_sid),
      {:form, ["From": @twilio_number, "To": to, "Body": body, "MessagingServiceSid": twilio_msid]},
      [],
      [ hackney: auth_key(twilio_sid, twilio_token) ])

    response.body
    |> FutureAdvisorMessaging.Http.process_response_body
  end

  def auth_key(sid, token) do
    [basic_auth: {sid, token}]
  end

  def request_url(endpoint, sid) do
    "#{endpoint}#{sid}/Messages.json"
  end

  defp twilio_info do
    {
      Application.get_env(:future_advisor_messaging, :twilio_token),
      Application.get_env(:future_advisor_messaging, :twilio_sid),
      Application.get_env(:future_advisor_messaging, :twilio_msid),
      Application.get_env(:future_advisor_messaging, :twilio_sms_url)
    }
  end
end
