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
    {200, %{"success" => "true", "status" => "Service is running"}}
  end

  post "/send" do
    {:ok, data, _none} = Plug.Conn.read_body(conn)
    # {:ok, data} = JSX.decode(data)

    data
    |> FutureAdvisorMessaging.Http.log_request
    |> FutureAdvisorMessaging.Http.decode_json
    |> format_data
    |> validate_sms_request
    |> FutureAdvisorMessaging.Sms.send_to_numbers

    # we can add a handler here to return data that
    # we need
    {200, %{"success" => "true"}}
  end

  defp validate_sms_request({numbers, message}) do
    {numbers, message}
  end

  defp format_data(res) do
    {res["phone_numbers"], res["message"]}
  end

  import_routes Trot.NotFound
end
