defmodule Derrit.Repo do
  use Ecto.Repo,
    otp_app: :derrit,
    adapter: Ecto.Adapters.Postgres
end
