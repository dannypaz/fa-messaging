defmodule FutureAdvisorMessaging.Mixfile do
  use Mix.Project

  def project do
    [app: :fa_messaging,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :kernel]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  #

  #
  # We need to override `poison` dep here because trot/ex_twilio use
  # conflicting versions and we dont got time fer dat.
  defp deps do
    [{:httpoison, "~> 0.8.0"},
     {:poison, "~> 2.2", override: true},
     {:trot, github: "hexedpackets/trot"},
     {:mock, "~> 0.2.0", only: :test}]
  end
end
