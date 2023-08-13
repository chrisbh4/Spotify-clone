defmodule Spotify.AlbumsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Spotify.Albums` context.
  """

  @doc """
  Generate a album.
  """
  def album_fixture(attrs \\ %{}) do
    {:ok, album} =
      attrs
      |> Enum.into(%{
        artist_name: "some artist_name",
        title: "some title"
      })
      |> Spotify.Albums.create_album()

    album
  end
end
