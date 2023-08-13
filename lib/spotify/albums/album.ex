defmodule Spotify.Albums.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :artist_name, :string
    field :title, :string
    field :image, :string

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:title, :artist_name, :image])
    |> validate_required([:title, :artist_name])
  end
end
