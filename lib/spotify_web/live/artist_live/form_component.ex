defmodule SpotifyWeb.ArtistLive.FormComponent do
  use SpotifyWeb, :live_component

  alias Spotify.Artists

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage artist records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="artist-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:bio]} type="text" label="Bio" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Artist</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{artist: artist} = assigns, socket) do
    changeset = Artists.change_artist(artist)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"artist" => artist_params}, socket) do
    changeset =
      socket.assigns.artist
      |> Artists.change_artist(artist_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"artist" => artist_params}, socket) do
    save_artist(socket, socket.assigns.action, artist_params)
  end

  defp save_artist(socket, :edit, artist_params) do
    case Artists.update_artist(socket.assigns.artist, artist_params) do
      {:ok, artist} ->
        notify_parent({:saved, artist})

        {:noreply,
         socket
         |> put_flash(:info, "Artist updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_artist(socket, :new, artist_params) do
    case Artists.create_artist(artist_params) do
      {:ok, artist} ->
        notify_parent({:saved, artist})

        {:noreply,
         socket
         |> put_flash(:info, "Artist created successfully")
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
