defmodule FutureAdvisorMessaging.Sms do

  # For send_to_numbers, we validate the params sent and then we make 1 request
  # per number to send an SMS
  #
  # Each request is run inside of its own async task then we track each success
  # and return the total amount and the sent total in the response
  def send_to_numbers({numbers, message}) do
    cond do
      blank_message?(message) ->
        {:error, "Message cannot be blank."}
      list_empty?(numbers) ->
        {:error, "Must provide at least one (1) valid phone number."}
      true ->
        numbers
        |> Enum.map(fn(num) -> Task.async(fn -> send_to_number(num, message) end) end)
        |> Enum.map(&Task.await/1)
        |> Enum.reduce(0, fn(res, acc) -> res |> get_status_from_response |> get_value_from_status |> Kernel.+(acc) end)
        |> send_response(Kernel.length(numbers))
    end
  end

  defp send_response(sent, total) do
    {:ok, {sent, total}}
  end

  # For send_to_number, if the user_phone passed in is an empty string,
  # we will `:empty` and skip the API request altogether.
  #
  # If user_phone is valid, then we will send a request through the twilio API
  defp send_to_number("", _message), do: :empty
  defp send_to_number(user_phone, message) do
    FutureAdvisorMessaging.Twilio.create(user_phone, message)
  end

  # If the API response is empty, then we will return 0 which will not
  # trigger logic which adds a value to the sent accumulation
  defp get_status_from_response(:empty), do: 0

  # We parse any HTTP responses and convert them into Map(:atoms) which is how
  # we are able to grab :status from the response
  defp get_status_from_response(response) do
    response[:status]
  end

  # Twilio returns "accepted" if the text message has been sent
  # correctly, else it returns HTTP status codes indicating what error
  # has occured.
  #
  # We return a Integer of 1 which is used in the accumulation of a total sent count.
  #
  defp get_value_from_status("accepted") do
    1
  end

  # If any other Twilio status other than "accepted" is sent, we will assume that
  # the API has found an error and we will return 0, which will leave the
  # total sent count unaffected.
  defp get_value_from_status(_status) do
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
