defmodule Spotify.User_PlaylistTest do
  use Spotify.DataCase

  alias Spotify.User_Playlist

  describe "playlists" do
    alias Spotify.User_Playlist.Playlist

    import Spotify.User_PlaylistFixtures

    @invalid_attrs %{name: nil, tracks_total: nil}

    test "list_playlists/0 returns all playlists" do
      playlist = playlist_fixture()
      assert User_Playlist.list_playlists() == [playlist]
    end

    test "get_playlist!/1 returns the playlist with given id" do
      playlist = playlist_fixture()
      assert User_Playlist.get_playlist!(playlist.id) == playlist
    end

    test "create_playlist/1 with valid data creates a playlist" do
      valid_attrs = %{name: "some name", tracks_total: 42}

      assert {:ok, %Playlist{} = playlist} = User_Playlist.create_playlist(valid_attrs)
      assert playlist.name == "some name"
      assert playlist.tracks_total == 42
    end

    test "create_playlist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User_Playlist.create_playlist(@invalid_attrs)
    end

    test "update_playlist/2 with valid data updates the playlist" do
      playlist = playlist_fixture()
      update_attrs = %{name: "some updated name", tracks_total: 43}

      assert {:ok, %Playlist{} = playlist} = User_Playlist.update_playlist(playlist, update_attrs)
      assert playlist.name == "some updated name"
      assert playlist.tracks_total == 43
    end

    test "update_playlist/2 with invalid data returns error changeset" do
      playlist = playlist_fixture()
      assert {:error, %Ecto.Changeset{}} = User_Playlist.update_playlist(playlist, @invalid_attrs)
      assert playlist == User_Playlist.get_playlist!(playlist.id)
    end

    test "delete_playlist/1 deletes the playlist" do
      playlist = playlist_fixture()
      assert {:ok, %Playlist{}} = User_Playlist.delete_playlist(playlist)
      assert_raise Ecto.NoResultsError, fn -> User_Playlist.get_playlist!(playlist.id) end
    end

    test "change_playlist/1 returns a playlist changeset" do
      playlist = playlist_fixture()
      assert %Ecto.Changeset{} = User_Playlist.change_playlist(playlist)
    end
  end
end
