defmodule Spotify.Repo.Migrations.PlaylistSongs do
  use Ecto.Migration

  def change do
    create table(:playlist_songs) do
      add :playlist_id, references(:playlists, on_delete: :nothing)
      add :song_id, references(:tracks, on_delete: :nothing)

      timestamps()
  end
    create unique_index(:playlist_songs, [:playlist_id, :song_id])
end
end
