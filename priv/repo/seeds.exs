# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Spotify.Repo.insert!(%Spotify.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Spotify.Repo
alias Spotify.Account.User
alias Spotify.Albums.Album
alias Spotify.User_Playlist.Playlist




Repo.insert!(%User{
  email: "demo@user.com",
  password: "password",
  hashed_password: Bcrypt.hash_pwd_salt("password")
})

Repo.insert!(%User{
  email: "spotify@email.com",
  password: "password",
  hashed_password: Bcrypt.hash_pwd_salt("password")
})

Repo.insert!(%User{
  email: "fake@user.com",
  password: "password",
  hashed_password: Bcrypt.hash_pwd_salt("password")
})


Repo.insert!(%Album{
  title: "Views",
  artist_name: "Drake"
})

Repo.insert!(%Album{
  title: "Certified Lover Boy",
  artist_name: "Drake"
})

Repo.insert!(%Album{
  title: "Her Loss",
  artist_name: "Drake & 21 Savage"
})

Repo.insert!(%Album{
  title: "Utopia",
  artist_name: "Travis Scott"
})


Repo.insert!(%Playlist{
  name: "Demo's Playlist",
  description: "This playlist goes crazzzzy!!!",
  tracks_total: 23
})

Repo.insert!(%Playlist{
  name: "Fav Rapper's colab",
  description: "Fire!!!!!",
  tracks_total: 8
})
