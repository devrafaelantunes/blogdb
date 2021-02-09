defmodule BlogDB.Repo do
  use Ecto.Repo,
    otp_app: :blogdb2,
    adapter: Ecto.Adapters.Postgres
end
