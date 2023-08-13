defmodule SpotifyWeb.TrackLive.FormComponent do
  use SpotifyWeb, :live_component

  alias Spotify.Tracks

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage track records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="track-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:duration]} type="number" label="Duration" />
        <.input field={@form[:release_date]} type="date" label="Release date" />
        <.input field={@form[:genre]} type="text" label="Genre" />
        <.input field={@form[:stream_url]} type="text" label="Stream url" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Track</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{track: track} = assigns, socket) do
    changeset = Tracks.change_track(track)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"track" => track_params}, socket) do
    changeset =
      socket.assigns.track
      |> Tracks.change_track(track_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"track" => track_params}, socket) do
    save_track(socket, socket.assigns.action, track_params)
  end

  defp save_track(socket, :edit, track_params) do
    case Tracks.update_track(socket.assigns.track, track_params) do
      {:ok, track} ->
        notify_parent({:saved, track})

        {:noreply,
         socket
         |> put_flash(:info, "Track updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_track(socket, :new, track_params) do
    case Tracks.create_track(track_params) do
      {:ok, track} ->
        notify_parent({:saved, track})

        {:noreply,
         socket
         |> put_flash(:info, "Track created successfully")
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
