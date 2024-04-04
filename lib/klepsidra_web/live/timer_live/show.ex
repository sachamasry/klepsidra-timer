defmodule KlepsidraWeb.TimerLive.Show do
  @moduledoc false

  use KlepsidraWeb, :live_view

  alias Klepsidra.TimeTracking

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:timer, TimeTracking.get_timer!(id))}
  end

  defp page_title(:show), do: "Show Timer"
  defp page_title(:edit), do: "Edit Timer"
end
