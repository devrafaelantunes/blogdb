use Mix.Config

config :music_db, MusicDB.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  adapter: Ecto.Adapters.Postgres,
  username: postgres,
  password: postgres,
  database: "blogdb2_repo",
  hostname: "localhost"
