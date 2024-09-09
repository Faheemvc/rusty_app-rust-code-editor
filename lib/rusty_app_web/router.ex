defmodule RustyAppWeb.Router do
  use RustyAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RustyAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RustyAppWeb do
    pipe_through :browser

    live "/", RhaiEditorLive

    live "/rust_functions", RustyFunctionsLive.Index, :index
    live "/rust_functions/new", RustyFunctionsLive.Index, :new
    live "/rust_functions/:id/edit", RustyFunctionsLive.Index, :edit

    live "/rust_functions/:id", RustyFunctionsLive.Show, :show
    live "/rust_functions/:id/show/edit", RustyFunctionsLive.Show, :edit

  end

  # Other scopes may use custom stacks.
  # scope "/api", RustyAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:rusty_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RustyAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
