defmodule SpotifyWeb.ArtistLiveTest do
  use SpotifyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Spotify.ArtistsFixtures

  @create_attrs %{bio: "some bio", name: "some name"}
  @update_attrs %{bio: "some updated bio", name: "some updated name"}
  @invalid_attrs %{bio: nil, name: nil}

  defp create_artist(_) do
    artist = artist_fixture()
    %{artist: artist}
  end

  describe "Index" do
    setup [:create_artist]

    test "lists all artists", %{conn: conn, artist: artist} do
      {:ok, _index_live, html} = live(conn, ~p"/artists")

      assert html =~ "Listing Artists"
      assert html =~ artist.bio
    end

    test "saves new artist", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/artists")

      assert index_live |> element("a", "New Artist") |> render_click() =~
               "New Artist"

      assert_patch(index_live, ~p"/artists/new")

      assert index_live
             |> form("#artist-form", artist: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#artist-form", artist: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/artists")

      html = render(index_live)
      assert html =~ "Artist created successfully"
      assert html =~ "some bio"
    end

    test "updates artist in listing", %{conn: conn, artist: artist} do
      {:ok, index_live, _html} = live(conn, ~p"/artists")

      assert index_live |> element("#artists-#{artist.id} a", "Edit") |> render_click() =~
               "Edit Artist"

      assert_patch(index_live, ~p"/artists/#{artist}/edit")

      assert index_live
             |> form("#artist-form", artist: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#artist-form", artist: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/artists")

      html = render(index_live)
      assert html =~ "Artist updated successfully"
      assert html =~ "some updated bio"
    end

    test "deletes artist in listing", %{conn: conn, artist: artist} do
      {:ok, index_live, _html} = live(conn, ~p"/artists")

      assert index_live |> element("#artists-#{artist.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#artists-#{artist.id}")
    end
  end

  describe "Show" do
    setup [:create_artist]

    test "displays artist", %{conn: conn, artist: artist} do
      {:ok, _show_live, html} = live(conn, ~p"/artists/#{artist}")

      assert html =~ "Show Artist"
      assert html =~ artist.bio
    end

    test "updates artist within modal", %{conn: conn, artist: artist} do
      {:ok, show_live, _html} = live(conn, ~p"/artists/#{artist}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Artist"

      assert_patch(show_live, ~p"/artists/#{artist}/show/edit")

      assert show_live
             |> form("#artist-form", artist: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#artist-form", artist: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/artists/#{artist}")

      html = render(show_live)
      assert html =~ "Artist updated successfully"
      assert html =~ "some updated bio"
    end
  end
end
