defmodule RustyApp.Repo do
  use Ecto.Repo,
    otp_app: :rusty_app,
    adapter: Ecto.Adapters.Postgres
end
