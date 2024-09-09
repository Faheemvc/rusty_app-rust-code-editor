defmodule RustyApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RustyAppWeb.Telemetry,
      RustyApp.Repo,
      {DNSCluster, query: Application.get_env(:rusty_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RustyApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RustyApp.Finch},
      # Start a worker by calling: RustyApp.Worker.start_link(arg)
      # {RustyApp.Worker, arg},
      # Start to serve requests, typically the last entry
      RustyAppWeb.Endpoint,

      {Redix, {redis_url(), redis_opts()}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RustyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RustyAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp redis_url do
    System.get_env("REDIS_URL") || "redis://localhost:6379"
  end

  defp redis_opts do
    [
      name: :redix,
      password: System.get_env("REDIS_PASSWORD"),
      socket_opts: [:inet6],
      timeout: 5000
    ]
  end
end
