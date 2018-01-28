# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :database,
  ecto_repos: [Database.Repo]

# Configures the endpoint
config :database, Database.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dCpUPOc8HoYVpDXMiC3yRVoVQly6EZ1BHew5W2EWUVZz0FHihgJft/ne+Y9yhT5D",
  render_errors: [view: Database.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Database.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# The rummage configurations
config :rummage_ecto, Rummage.Ecto,
  default_repo: Database.Repo,
  default_per_page: 10