# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

Application.put_env(:future_advisor_messaging, :twilio_sid, System.get_env("TWILIO_ACCOUNT_SID"))
Application.put_env(:future_advisor_messaging, :twilio_token, System.get_env("TWILIO_AUTH_TOKEN"))
Application.put_env(:future_advisor_messaging, :twilio_msid, System.get_env("TWILIO_MESSAGE_ACCOUNT_SID"))
Application.put_env(:future_advisor_messaging, :twilio_sms_url, System.get_env("TWILIO_SMS_URL"))

config :trot, :port, 4001
config :trot, :router, FutureAdvisorMessaging.Router

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :fa_messaging, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:fa_messaging, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
