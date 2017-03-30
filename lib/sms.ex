defmodule FutureAdvisorMessaging.Sms do
  def send_to_numbers({numbers, message}) do
    cond do
      String.trim(message) == "" ->
        {:error, "Message cannot be blank."}
      list_empty?(numbers) ->
        {:error, "Must provide atleast one (1) valid phone number."}
      true ->
        Enum.each(numbers, fn(x) -> send_to_number(x, message) end)
        {:ok, "true"}
    end
  end

  defp send_to_number(user_phone, message) do
    FutureAdvisorMessaging.Twilio.create(user_phone, message)
  end

  defp list_empty?(list) do
    first_num = list |> List.first |> String.trim
    last_num = list |> List.last |> String.trim
    first_num == "" && last_num == ""
  end
end
