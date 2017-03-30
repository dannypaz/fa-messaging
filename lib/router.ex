# Things to do....
# 1. add bugsnag
# 1a. Figure out what kind of response we want to receive?
# 1b. Figure out how to deploy this thing
# 1c. Remove dependecy from Twilex and just use HTTP yourself?
# 1d. Dont cry because it's over, smile because it happened.
# 1e. Test case will be grabbing everyones cellphone # from pingboard
# and sending them all an SMS from an advisor with their names?*****
# 1f. Send lizzie really corny memes to send to all employees
# 2. validate json?
# 3. refactor or clean up code
# 4. request limit (because of $$)
# 5. prevent duplicate numbers from getting same message

defmodule FutureAdvisorMessaging.Router do
  use Trot.Router

  get "/" do
    {200, %{"success" => "true", "status" => "Here is the service test"}}
  end

  post "/send" do
    {:ok, data, _none} = Plug.Conn.read_body(conn)
    # {:ok, data} = JSX.decode(data)

    data
    |> log_request
    |> decode_json
    |> format_data
    |> send_sms_to_numbers

    # we can add a handler here to return data that
    # we need
    {200, %{"success" => "true"}}
  end

  defp log_request(data) do
    IO.inspect data
    data
  end

  defp decode_json(data) do
    Poison.decode!(data)
  end

  defp format_data(res) do
    {res["phone_numbers"], res["message"]}
  end

  defp send_sms_to_numbers({numbers, message}) do
    Enum.each(numbers, fn(x) -> send_sms_to_number(x, message) end)
  end

  defp send_sms_to_number(user_phone, message) do
    IO.puts "Phone: #{user_phone}"
    IO.puts "Message: #{message}"

    FutureAdvisorMessaging.Http.create(
      "+15867899278",
      user_phone,
      message
    )
  end

  use Trot.NotFound
end
