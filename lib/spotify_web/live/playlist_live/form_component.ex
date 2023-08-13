defmodule SpotifyWeb.PlaylistLive.FormComponent do
  use SpotifyWeb, :live_component

  import Logger

  alias Spotify.User_Playlist

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage playlist records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="playlist-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" phx-debounce="500" />
        <.input field={@form[:description]} type="text" label="Description" phx-debounce="500" />
        <.input field={@form[:tracks_total]} type="number" label="Tracks total" phx-debounce="500" />
        <.input field={@form[:image]} type="text" value="Image" label="Image Upload" phx-debounce="500" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Playlist</.button>
          <%!-- <.button type="reset" name="reset">Reset</.button> --%>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{playlist: playlist} = assigns, socket) do
    changeset = User_Playlist.change_playlist(playlist)
    Logger.info(playlist: playlist)
    Logger.info(changeset: changeset)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"playlist" => playlist_params}, socket) do
    changeset =
      socket.assigns.playlist
      |> User_Playlist.change_playlist(playlist_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"playlist" => playlist_params}, socket) do
    save_playlist(socket, socket.assigns.action, playlist_params)
  end

  defp save_playlist(socket, :edit, playlist_params) do
    case User_Playlist.update_playlist(socket.assigns.playlist, playlist_params) do
      {:ok, playlist} ->
        notify_parent({:saved, playlist})

        {:noreply,
         socket
         |> put_flash(:info, "Playlist updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_playlist(socket, :new, playlist_params) do
    case User_Playlist.create_playlist(playlist_params) do
      {:ok, playlist} ->
        notify_parent({:saved, playlist})

        {:noreply,
         socket
         |> put_flash(:info, "Playlist created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
