defmodule SpotifyWeb.PlaylistLive.Show do
  use SpotifyWeb, :live_view

  alias Spotify.User_Playlist

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:playlist, User_Playlist.get_playlist!(id))}
  end

  defp page_title(:show), do: "Show Playlist"
  defp page_title(:edit), do: "Edit Playlist"
end
