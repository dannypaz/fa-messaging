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

  defmodule ParamsMissingError do
  end

  get "/" do
    {200, %{"success" => "true", "status" => "Service is running"}}
  end

  post "/send" do
    {:ok, data, _none} = Plug.Conn.read_body(conn)
    # {:ok, data} = JSX.decode(data)

    formatted_data = data
    |> FutureAdvisorMessaging.Http.log_request
    |> FutureAdvisorMessaging.Http.decode_json
    |> format_data

    FutureAdvisorMessaging.Sms.send_to_numbers(formatted_data)
    |> send_response
  end

  defp send_response({:ok, {sent, tried}}) do
    {200, %{"sent" => sent, "tried" => tried}}
  end

  defp send_response({:error, message}) do
    {400, %{"error" => message}}
  end

  defp format_data(res) do
    {res["phone_numbers"], res["message"]}
  end

  import_routes Trot.NotFound
end
