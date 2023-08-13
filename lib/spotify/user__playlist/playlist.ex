defmodule Spotify.User_Playlist.Playlist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "playlists" do
    field :name, :string
    field :tracks_total, :integer
    field :description, :string
    field :image, :string

    timestamps()
  end

  @doc false
  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [:name, :tracks_total, :description, :image])
    |> validate_required([:name, :tracks_total])
  end
end
