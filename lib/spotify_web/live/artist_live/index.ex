defmodule SpotifyWeb.ArtistLive.Index do
  use SpotifyWeb, :live_view

  alias Spotify.Artists
  alias Spotify.Artists.Artist

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :artists, Artists.list_artists())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Artist")
    |> assign(:artist, Artists.get_artist!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Artist")
    |> assign(:artist, %Artist{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Artists")
    |> assign(:artist, nil)
  end

  @impl true
  def handle_info({SpotifyWeb.ArtistLive.FormComponent, {:saved, artist}}, socket) do
    {:noreply, stream_insert(socket, :artists, artist)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    artist = Artists.get_artist!(id)
    {:ok, _} = Artists.delete_artist(artist)

    {:noreply, stream_delete(socket, :artists, artist)}
  end
end
