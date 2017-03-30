defmodule FutureAdvisorMessaging.Http do
  @endpoint "https://api.twilio.com/2010-04-01/Accounts/"
  @twilio_sid System.get_env("TWILIO_ACCOUNT_SID")
  @twilio_token System.get_env("TWILIO_AUTH_TOKEN")
  @twilio_msid System.get_env("TWILIO_MESSAGE_ACCOUNT_SID")

  def create(from, to, body) do
    {:ok, response} = HTTPoison.post(
      request_url(),
      {:form, ["From": from, "To": to, "Body": body, "MessagingServiceSid": @twilio_msid]},
      [],
      [ hackney: auth_key() ])

    response.body
    |> process_response_body
  end

  def auth_key do
    [basic_auth: {@twilio_sid, @twilio_token}]
  end

  def request_url do
    "#{@endpoint}#{@twilio_sid}/Messages.json"
  end

  def process_response_body(body) do
    IO.inspect "here is the body: #{body}"
    body
    |> Poison.decode!
    |> Enum.reduce(%{}, fn({k, v}, acc) -> Map.put(acc, String.to_atom(k), v) end)
  end
end
