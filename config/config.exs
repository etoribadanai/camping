# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :camping,
  ecto_repos: [Camping.Repo]

# Configures the endpoint
config :camping, CampingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/tAJrJDQajHg26ax/lkZBa0+17L6RCsoHxPlImALhS/r7UCGMd9XOtvT97s2/M8R",
  render_errors: [view: CampingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Camping.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :camping, Camping.Email.Mailer,
  adapter: Bamboo.SparkPostAdapter,
  api_key: "efbf17887fa4cc76f7bf0eddb76f9ad5830b09b8"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :camping, Camping.Guardian,
  issuer: "camping",
  secret_key: "TfGWNF0GdRKIpC9ysITNTv8kNc2Y0LZSG1+fQjz49YMTJR+O1rfrBfWLhihvKWtM"
