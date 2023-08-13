defmodule Spotify.Artists.Artist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field :bio, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [:name, :bio])
    |> validate_required([:name, :bio])
  end
end
