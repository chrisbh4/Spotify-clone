# Spotify

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


Database Schema

Playlist{
  id,
  name,
  description,
  user_id,
  image,
  playlist_song:{
    artist_id, ref: Artisit
    album_id, ref: Album
    song_id,  ref: Song
  }
}

Playlist_songs (Joins table){
  id,
  playlist_id,
  song_id,
}

Song{
  id,
  name/title,
  artist_id, ref: Artist
  album_id, ref: Album
  duration,
}

Follows{
  id,
  
}
