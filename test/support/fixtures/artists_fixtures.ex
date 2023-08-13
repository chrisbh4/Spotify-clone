defmodule Spotify.ArtistsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Spotify.Artists` context.
  """

  @doc """
  Generate a artist.
  """
  def artist_fixture(attrs \\ %{}) do
    {:ok, artist} =
      attrs
      |> Enum.into(%{
        bio: "some bio",
        name: "some name"
      })
      |> Spotify.Artists.create_artist()

    artist
  end
end
