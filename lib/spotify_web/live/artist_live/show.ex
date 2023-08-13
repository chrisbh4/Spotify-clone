defmodule SpotifyWeb.ArtistLive.Show do
  use SpotifyWeb, :live_view

  alias Spotify.Artists

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:artist, Artists.get_artist!(id))}
  end

  defp page_title(:show), do: "Show Artist"
  defp page_title(:edit), do: "Edit Artist"
end
