defmodule Spotify.Repo.Migrations.CreateArtists do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name, :string
      add :bio, :string

      timestamps()
    end
  end
end
