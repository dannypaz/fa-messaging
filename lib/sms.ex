defmodule FutureAdvisorMessaging.Sms do
  def send_to_numbers({numbers, message}) do
    cond do
      blank_message?(message) ->
        {:error, "Message cannot be blank."}
      list_empty?(numbers) ->
        {:error, "Must provide atleast one (1) valid phone number."}
      true ->
        Enum.each(numbers, fn(x) -> send_to_number(x, message) end)
        {:ok, "Total: Sent:"}
    end
  end

  defp send_to_number("", _message) do
    {:error, "number cannot be blank"}
  end

  defp send_to_number(user_phone, message) do
    FutureAdvisorMessaging.Twilio.create(user_phone, message)
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
