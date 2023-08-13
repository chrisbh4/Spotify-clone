defmodule Spotify.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :title, :string
      add :artist_name, :string
      add :image, :string 

      timestamps()
    end
  end
end
