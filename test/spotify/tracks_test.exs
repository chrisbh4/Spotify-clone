defmodule Spotify.TracksTest do
  use Spotify.DataCase

  alias Spotify.Tracks

  describe "tracks" do
    alias Spotify.Tracks.Track

    import Spotify.TracksFixtures

    @invalid_attrs %{duration: nil, genre: nil, release_date: nil, stream_url: nil, title: nil}

    test "list_tracks/0 returns all tracks" do
      track = track_fixture()
      assert Tracks.list_tracks() == [track]
    end

    test "get_track!/1 returns the track with given id" do
      track = track_fixture()
      assert Tracks.get_track!(track.id) == track
    end

    test "create_track/1 with valid data creates a track" do
      valid_attrs = %{duration: 42, genre: "some genre", release_date: ~D[2023-08-12], stream_url: "some stream_url", title: "some title"}

      assert {:ok, %Track{} = track} = Tracks.create_track(valid_attrs)
      assert track.duration == 42
      assert track.genre == "some genre"
      assert track.release_date == ~D[2023-08-12]
      assert track.stream_url == "some stream_url"
      assert track.title == "some title"
    end

    test "create_track/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracks.create_track(@invalid_attrs)
    end

    test "update_track/2 with valid data updates the track" do
      track = track_fixture()
      update_attrs = %{duration: 43, genre: "some updated genre", release_date: ~D[2023-08-13], stream_url: "some updated stream_url", title: "some updated title"}

      assert {:ok, %Track{} = track} = Tracks.update_track(track, update_attrs)
      assert track.duration == 43
      assert track.genre == "some updated genre"
      assert track.release_date == ~D[2023-08-13]
      assert track.stream_url == "some updated stream_url"
      assert track.title == "some updated title"
    end

    test "update_track/2 with invalid data returns error changeset" do
      track = track_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracks.update_track(track, @invalid_attrs)
      assert track == Tracks.get_track!(track.id)
    end

    test "delete_track/1 deletes the track" do
      track = track_fixture()
      assert {:ok, %Track{}} = Tracks.delete_track(track)
      assert_raise Ecto.NoResultsError, fn -> Tracks.get_track!(track.id) end
    end

    test "change_track/1 returns a track changeset" do
      track = track_fixture()
      assert %Ecto.Changeset{} = Tracks.change_track(track)
    end
  end
end
