defmodule Spotify.Repo.Migrations.CreatePlaylists do
  use Ecto.Migration

  def change do
    create table(:playlists) do
      add :name, :string
      add :tracks_total, :integer
      add :description, :string
      add :image, :string

      timestamps()
    end
  end
end
