defmodule Spotify.AlbumsTest do
  use Spotify.DataCase

  alias Spotify.Albums

  describe "albums" do
    alias Spotify.Albums.Album

    import Spotify.AlbumsFixtures

    @invalid_attrs %{artist_name: nil, title: nil}

    test "list_albums/0 returns all albums" do
      album = album_fixture()
      assert Albums.list_albums() == [album]
    end

    test "get_album!/1 returns the album with given id" do
      album = album_fixture()
      assert Albums.get_album!(album.id) == album
    end

    test "create_album/1 with valid data creates a album" do
      valid_attrs = %{artist_name: "some artist_name", title: "some title"}

      assert {:ok, %Album{} = album} = Albums.create_album(valid_attrs)
      assert album.artist_name == "some artist_name"
      assert album.title == "some title"
    end

    test "create_album/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Albums.create_album(@invalid_attrs)
    end

    test "update_album/2 with valid data updates the album" do
      album = album_fixture()
      update_attrs = %{artist_name: "some updated artist_name", title: "some updated title"}

      assert {:ok, %Album{} = album} = Albums.update_album(album, update_attrs)
      assert album.artist_name == "some updated artist_name"
      assert album.title == "some updated title"
    end

    test "update_album/2 with invalid data returns error changeset" do
      album = album_fixture()
      assert {:error, %Ecto.Changeset{}} = Albums.update_album(album, @invalid_attrs)
      assert album == Albums.get_album!(album.id)
    end

    test "delete_album/1 deletes the album" do
      album = album_fixture()
      assert {:ok, %Album{}} = Albums.delete_album(album)
      assert_raise Ecto.NoResultsError, fn -> Albums.get_album!(album.id) end
    end

    test "change_album/1 returns a album changeset" do
      album = album_fixture()
      assert %Ecto.Changeset{} = Albums.change_album(album)
    end
  end
end
