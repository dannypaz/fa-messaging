defmodule FutureAdvisorMessaging.Sms do
  def send_to_numbers({numbers, message}) do
    Enum.each(numbers, fn(x) -> send_to_number(x, message) end)
  end

  defp send_to_number(user_phone, message) do
    FutureAdvisorMessaging.Twilio.create(user_phone, message)
  end
end
