# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :derrit,
  ecto_repos: [Derrit.Repo]

# Configures the endpoint
config :derrit, DerritWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7ctSo1gXqHabS4GtzcWs7I/cNrhjfDsPuy7LN4n6+qC54cJLGC+2UPtHEBYggaEk",
  render_errors: [view: DerritWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Derrit.PubSub,
  live_view: [signing_salt: "r/NEnBD8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
