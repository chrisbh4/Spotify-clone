defmodule Spotify.TracksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Spotify.Tracks` context.
  """

  @doc """
  Generate a track.
  """
  def track_fixture(attrs \\ %{}) do
    {:ok, track} =
      attrs
      |> Enum.into(%{
        duration: 42,
        genre: "some genre",
        release_date: ~D[2023-08-12],
        stream_url: "some stream_url",
        title: "some title"
      })
      |> Spotify.Tracks.create_track()

    track
  end
end
