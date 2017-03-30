defmodule FutureAdvisorMessaging.Http do
  @endpoint "https://api.twilio.com/2010-04-01/Accounts/"

  def create(from, to, body) do
    {:ok, response} = HTTPoison.post(
      request_url(),
      {:form, ["From": from, "To": to, "Body": body, "MessagingServiceSid": twilio_msid()]},
      [],
      [ hackney: auth_key() ])

    response.body
    |> process_response_body
  end

  def auth_key do
    [basic_auth: {twilio_sid(), twilio_token()}]
  end

  def request_url do
    "#{@endpoint}#{twilio_sid()}/Messages.json"
  end

  def process_response_body(body) do
    IO.inspect "here is the body: #{body}"
    body
    |> Poison.decode!
    |> Enum.reduce(%{}, fn({k, v}, acc) -> Map.put(acc, String.to_atom(k), v) end)
  end

  defp twilio_token do
    Application.get_env(:future_advisor_messaging, :twilio_token)
  end

  defp twilio_sid do
    Application.get_env(:future_advisor_messaging, :twilio_sid)
  end

  defp twilio_msid do
    Application.get_env(:future_advisor_messaging, :twilio_msid)
  end
end
