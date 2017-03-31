# FutureAdvisorMessaging

Stateless micro-service for handling batch SMS message sending. We currently use Twilio as our provider ([ExTwilio](https://github.com/danielberkompas/ex_twilio))

## Before you begin

1. Install erlang through homebrew
2. Install kiex, an elixir version manager
3. Install the correct elixir version (you can find the version in .elixir-version)
4. Create a `.env` with correct keys (listed below)

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

Once kiex is installed, we can now install elixir. The current Elixir version of this project is located in `.elixir-version`. You may be prompted with questions asking if you want to install something "Y/n". Select Yes. (this may only be applicable for "brand spankin' new" Elixir installations)

```
kiex install 1.4.2
kiex use 1.4.2
mix deps.get
mix compile
```

Once these steps are completed, you will then have a compiled EX project (located in `/_build`). We need to load environment variables which are used for our Twilio interface. Either copy/rename the `.env-test` file at the root of the project OR add the following keys to a `.env` file at the root of the project:

```
export TWILIO_ACCOUNT_SID=<your-twilio-account-sid>
export TWILIO_AUTH_TOKEN=<your-twilion-auth-token>
export TWILIO_MESSAGE_ACCOUNT_SID=<your-message-sid>
export TWILIO_SMS_URL=https://api.twilio.com/2010-04-01/Accounts/
```

Load the environment variables with `source .env` and NOW you can safely run the server:

```
mix.trot.server
```

Finally, navigate to [http://localhost:1337](http://localhost:1337) and you should receive confirmation that the service is running.

### Development Tips

To compile the project, make sure you are in the root directory then use `mix compile`

Starting an iex session inside of the project `iex -S mix`

### Testing

Tests are located in /test and include test helpers (ExUnit). To run tests, use `mix test`

### Gotchas
When importing libraries, beginning with Elixir 1.4, you no longer have to specify third party dependencies in the mix file under `application`.

Please see this [article](http://elixir-lang.org/blog/2017/01/05/elixir-v1-4-0-released/) for more info.

**IF YOU EVER RECEIVE :badargs errors, it might be caused by not having environment variables loaded in your terminal session**

To load ENV variables, simply run `source .env`. You do have a `.env` file, right?
