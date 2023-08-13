defmodule Spotify.User_PlaylistFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Spotify.User_Playlist` context.
  """

  @doc """
  Generate a playlist.
  """
  def playlist_fixture(attrs \\ %{}) do
    {:ok, playlist} =
      attrs
      |> Enum.into(%{
        name: "some name",
        tracks_total: 42
      })
      |> Spotify.User_Playlist.create_playlist()

    playlist
  end
end
