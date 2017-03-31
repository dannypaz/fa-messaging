defmodule FutureAdvisorMessaging.Sms do
  def send_to_numbers({numbers, message}) do
    cond do
      blank_message?(message) ->
        {:error, "Message cannot be blank."}
      list_empty?(numbers) ->
        {:error, "Must provide at least one (1) valid phone number."}
      true ->
        sent = Enum.reduce(numbers, 0, fn(x, acc) -> send_to_number(x, message) + acc end)
        tried = Kernel.length(numbers)
        {:ok, {sent, tried}}
    end
  end

  defp send_to_number("", _message) do
    0
  end

  defp send_to_number(user_phone, message) do
    FutureAdvisorMessaging.Twilio.create(user_phone, message)
    |> get_status_from_response
    |> get_value_from_status
  end

  def get_status_from_response(response) do
    response[:status]
  end

  def get_value_from_status("accepted") do
    1
  end

  def get_value_from_status(_status) do
    0
  end

  defp list_empty?(list) do
    numbers = list |> List.first
    numbers == nil
  end

  defp blank_message?(message) do
    result = message |> String.trim
    result == ""
  end
end
