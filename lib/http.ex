defmodule FutureAdvisorMessaging.Http do
  def log_request(data) do
    data |> IO.inspect
    data
  end

  def decode_json(data) do
    data |> Poison.decode!
  end

  # We take the body of an HTTP request, parse the json and then convert
  # the result into a Map. This allows us to access data with an atom as the key.
  #
  # Example:
  # response[:my_key]
  #
  def process_response_body(body) do
    IO.inspect "Response Body: #{body}"

    body
    |> decode_json
    |> Enum.reduce(%{}, fn({k, v}, acc) -> Map.put(acc, String.to_atom(k), v) end)
  end
end
