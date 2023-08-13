defmodule Spotify.Tracks.Track do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tracks" do
    field :duration, :integer
    field :genre, :string
    field :release_date, :date
    field :stream_url, :string
    field :title, :string

    belongs_to :artist, Spotify.Artists
    belongs_to :album, Spotify.Albums

    timestamps()
  end

  @doc false
  def changeset(track, attrs) do
    track
    |> cast(attrs, [:title, :duration, :release_date, :genre, :stream_url])
    |> validate_required([:title, :duration, :release_date, :genre, :stream_url])
  end
end
