defmodule FutureAdvisorMessaging.Http do
  def log_request(data) do
    IO.inspect data
    data
  end

  def decode_json(data) do
    Poison.decode!(data)
  end

  def process_response_body(body) do
    IO.inspect "Body: #{body}"

    body
    |> Poison.decode!
    |> Enum.reduce(%{}, fn({k, v}, acc) -> Map.put(acc, String.to_atom(k), v) end)
  end
end
