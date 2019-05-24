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

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: AdminManager.User,
  repo: AdminManager.Repo,
  module: AdminManager,
  web_module: AdminManager,
  router: AdminManager.Router,
  messages_backend: AdminManager.Coherence.Messages,
  logged_out_url: "/admin",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :registerable]

config :coherence, AdminManager.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
