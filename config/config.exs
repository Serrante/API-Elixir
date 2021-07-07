# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :voting,
  ecto_repos: [Voting.Repo]

config :voting, Voting.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :voting, VotingWeb.Guardian,
  issuer: "voting",
  secret_key: "WTY4Ac7y+EFEg2RdR5eaDKU6dym0filwBJQGmh69NM6FFwp8MUZ1GIYrtArxokpK"

config :voting, VotingWeb.AuthAccessPipeline,
  module: VotingWeb.Guardian,
  error_handler: VotingWeb.AuthErrorHandler

# Configures the endpoint
config :voting, VotingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "l67JGUoKZEpRbMVN92lMrt8Kpo2dMGWO3D2BAkR/Z4wZAzqDurEfPnzYpGBVJa1v",
  render_errors: [view: VotingWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Voting.PubSub,
  live_view: [signing_salt: "/SlEUoSH"]

config :ex_aws,
  region: "eu-north-1",
  json_codec: Jason

config :voting,
  uploads_bucket: "app-elixir-voting",
  file_module: File

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
