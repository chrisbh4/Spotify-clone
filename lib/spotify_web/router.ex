defmodule SpotifyWeb.Router do
  use SpotifyWeb, :router

  import SpotifyWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SpotifyWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpotifyWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpotifyWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:spotify, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SpotifyWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", SpotifyWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{SpotifyWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      # live "/", NavLive, :index
      live "/home", HomeLive, :index
      live "/sign_up", UserRegistrationLive, :new
      live "/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
      # post "/demo_log_in", UserController, :demo_log_in
    end

    post "/log_in", UserSessionController, :create
  end

  scope "/", SpotifyWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
    on_mount: [{SpotifyWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email

      live "/playlists", PlaylistLive.Index, :index
      live "/playlists/new", PlaylistLive.Index, :new
      live "/playlists/:id/edit", PlaylistLive.Index, :edit
      live "/playlists/:id", PlaylistLive.Show, :show
      live "/playlists/:id/show/edit", PlaylistLive.Show, :edit

      live "/albums", AlbumLive.Index, :index
      live "/albums/new", AlbumLive.Index, :new
      live "/albums/:id/edit", AlbumLive.Index, :edit

      live "/albums/:id", AlbumLive.Show, :show
      live "/albums/:id/show/edit", AlbumLive.Show, :edit

      live "/tracks", TrackLive.Index, :index
      live "/tracks/new", TrackLive.Index, :new
      live "/tracks/:id/edit", TrackLive.Index, :edit

      live "/tracks/:id", TrackLive.Show, :show
      live "/tracks/:id/show/edit", TrackLive.Show, :edit

      live "/artists", ArtistLive.Index, :index
      live "/artists/new", ArtistLive.Index, :new
      live "/artists/:id/edit", ArtistLive.Index, :edit

      live "/artists/:id", ArtistLive.Show, :show
      live "/artists/:id/show/edit", ArtistLive.Show, :edit
    end
  end

  scope "/", SpotifyWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{SpotifyWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
