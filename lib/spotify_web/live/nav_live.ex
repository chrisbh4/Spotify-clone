defmodule SpotifyWeb.NavLive do
  use SpotifyWeb, :live_view
  import Logger
  import Plug.Conn
  alias Spotify.Account
  alias SpotifyWeb.UserAuth

  def render(assigns)do
    ~H"""
      <body class="bg-gray-200 antialiased">
        <ul class="bg-red-400 h-14  relative z-10 flex items-center gap-4 px-4 sm:px-6 lg:px-8 justify-end">
          <%= if @current_user do %>
            <li class="text-2xl leading-6 text-zinc-900">
              <%= @current_user.email %>
            </li>
            <li>
              <.link
                href={~p"/"}
                class="text-2xl leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Home
              </.link>
            </li>
            <li>
              <.link
                href={~p"/albums"}
                class="text-2xl leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Album
              </.link>
            </li>
            <li>
              <.link
                href={~p"/playlists"}
                class="text-2xl leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Playlist
              </.link>
            </li>
            <li>
              <.link
                href={~p"/users/settings"}
                class="text-2xl leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Settings
              </.link>
            </li>
            <li>
              <.link
                href={~p"/users/log_out"}
                method="delete"
                class="text-2xl leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Log out
              </.link>
            </li>
          <% else %>
            <li>
              <.link
                href={~p"/"}
                class="text-2xl leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Home
              </.link>
            </li>
            <li>
              <button
                class="text-2xl leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
                phx-click="demo-user"
              >
                Demo
              </button>
            </li>
            <li>
              <.link
                href={~p"/sign_up"}
                class="text-2xl leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Sign up
              </.link>
            </li>
            <li>
              <.link
                href={~p"/log_in"}
                class="text-2xl leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                Log in
              </.link>
            </li>
          <% end %>
        </ul>
        <%!-- <%= @inner_content %> --%>
      </body>
    """
  end


  def handle_event("demo-user", _params, socket) do
    demo = Account.get_user_by_email_and_password("demo@user.com", "password")
    # log_in = UserAuth.log_in_user(socket, %{email: "demo@user.com", password: "password"})
    # log_in = UserAuth.log_in_user(socket,demo)
    Logger.info(Demo: demo)
    {:noreply, socket}
  end
end
