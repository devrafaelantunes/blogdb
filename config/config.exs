import Config

config :blogdb2, BlogDB.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "blogdb2_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :blogdb2, ecto_repos: [BlogDB.Repo]
#import_config "#{Mix.env()}.exs"
