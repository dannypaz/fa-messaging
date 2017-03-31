# FutureAdvisorMessaging

Stateless micro-service for handling batch SMS message sending. We currently use Twilio as our provider ([ExTwilio](https://github.com/danielberkompas/ex_twilio))

## Before you begin

1. Install erlang through homebrew
2. Install kiex, an elixir version manager
3. Install the correct elixir version (you can find the version in .elixir-version)

#### Before you begin - detailed

You will need to install Erlang and Elixir to run the project. (This should be containerized later).

Erlang package manager is not required so we will install Erlang w/ brew since the version should not change _as much_ as elixir.

```
brew install erlang
```

Next we will need to install kiex, which is an awesome elixir version manager (and does not modify bash to work).

```
curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s
```

This command was taken from kiex docs on March 29th 2017. You can find more info [here](https://github.com/taylor/kiex).

Afterwards, check the version in `.elixir-version` and install it with the following:

```
kiex install <elixir-version>
kiex use 1.4.2
mix deps.get
mix compile
mix trot.server
```

## Running the project

To run the server: `mix trot.server` and navigate to [http://localhost:1337](http://localhost:1337)

## Development setup

### Development Tips

To compile the project, make sure you are in the root directory then use `mix compile`

Starting an iex session inside of the project `iex -S mix`

### Testing

Tests are located in /test and include test helpers (ExUnit). To run tests, use `mix test`

### Gotchas
When importing libraries, beginning with Elixir 1.4, you no longer have to specify third party dependencies in the mix file under `application`.

Please see this [article](http://elixir-lang.org/blog/2017/01/05/elixir-v1-4-0-released/) for more info.

IF YOU EVER RECEIVE A :BADARGS error, it is because you have no loaded environment variables
