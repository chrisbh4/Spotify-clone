defmodule Spotify.Repo.Migrations.CreateTracks do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :title, :string
      add :duration, :integer
      add :release_date, :date
      add :genre, :string
      add :stream_url, :string

      timestamps()
    end
  end
end
