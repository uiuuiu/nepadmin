# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :admin_manager,
  ecto_repos: [AdminManager.Repo]

# Configures the endpoint
config :admin_manager, AdminManager.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PVGRSpTeqoFmWFDzWVLkzjpOx+a7i96S0pbhZlkrSRG2GYg9LixPU2AzEaqEzDLt",
  render_errors: [view: AdminManager.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AdminManager.PubSub,
           adapter: Phoenix.PubSub.PG2],
  http: [protocol_options: [max_request_line_length: 8192, max_header_value_length: 8192]]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
    slim: PhoenixSlime.Engine,
    slime: PhoenixSlime.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
