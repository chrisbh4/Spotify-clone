defmodule Spotify.Repo.Migrations.CreatePlaylists do
  use Ecto.Migration

  def change do
    create table(:playlists) do
      add :name, :string
      add :tracks_total, :integer
      add :description, :string
      add :image, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:playlists, [:user_id])
  end
end
