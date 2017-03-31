defmodule FutureAdvisorMessaging.Twilio do
  @twilio_number "+15867899278"

  def create(to, body) do
    {twilio_token, twilio_sid, twilio_msid, twilio_sms_url} = twilio_info()

    url = generate_request_url(twilio_sms_url, twilio_sid)
    form_data = generate_form_data(to, body, twilio_msid)

    {url, form_data}
    |> send_request(twilio_sid, twilio_token)
    |> get_response_body
    |> FutureAdvisorMessaging.Http.process_response_body
  end

  def generate_form_data(to, body, msid) do
    {:form, ["From": @twilio_number, "To": to, "Body": body, "MessagingServiceSid": msid]}
  end

  def generate_request_url(endpoint, sid) do
    "#{endpoint}#{sid}/Messages.json"
  end

  def send_request({url, form_data}, sid, token) do
    HTTPoison.post(url, form_data, [], auth_key(sid, token))
  end

  defp get_response_body({:ok, res}), do: res.body
  defp get_response_body({:error, res}) do
    # Handle the error somehow
    res.body
  end

  defp auth_key(sid, token) do
    [hackney: [basic_auth: {sid, token}]]
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
