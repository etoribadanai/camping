defmodule Camping.Repo do
  use Ecto.Repo,
    otp_app: :camping,
    adapter: Ecto.Adapters.Postgres
end
