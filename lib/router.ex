# Things to do....
# 1. add bugsnag
# 1a. Figure out how to deploy this thing
# 1b. Dont cry because it's over, smile because it happened.
# 2. request limit (because of $$)
# 3. prevent duplicate numbers from getting same message

defmodule FutureAdvisorMessaging.Router do
  use Trot.Router

  get "/", do: {200, %{"status" => "Service is running"}}

  post "/send" do
    {:ok, request, _none} = Plug.Conn.read_body(conn)

    request
    |> FutureAdvisorMessaging.Http.log_request
    |> FutureAdvisorMessaging.Http.decode_json
    |> format_sms_response
    |> FutureAdvisorMessaging.Sms.send_to_numbers
    |> send_response
  end

  defp format_sms_response(res) do
    {res["phone_numbers"], res["message"]}
  end

  defp send_response({:ok, {sent, tried}}) do
    {200, %{"sent" => sent, "tried" => tried}}
  end

  defp send_response({:error, err}), do: {400, %{"error" => err}}

  import_routes Trot.NotFound
end
