defmodule KlepsidraWeb.TimerLive.FormComponent do
  @moduledoc false

  use KlepsidraWeb, :live_component

  alias Klepsidra.TimeTracking
  alias Klepsidra.Projects
  alias Klepsidra.BusinessPartners

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Manage activity timers.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="timer-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:start_stamp]} type="datetime-local" label="Start time" />
        <.input field={@form[:end_stamp]} type="datetime-local" label="End imestamp" />
        <.input field={@form[:duration]} type="number" label="Duration" />
        <.input
          field={@form[:duration_time_unit]}
          type="select"
          label="Duration time unit"
          options={[{"Hours", "hour"}, {"Minutes", "minute"}, {"Seconds", "second"}]}
          value="minute"
        />
        <.input field={@form[:reported_duration]} type="number" label="Reported duration" />
        <.input
          field={@form[:reported_duration_time_unit]}
          type="select"
          label="Reported duration time unit"
          options={[{"Hours", "hour"}, {"Minutes", "minute"}, {"Seconds", "second"}]}
          value="minute"
        />
        <.input field={@form[:description]} type="textarea" label="Description" />

        <.input
          field={@form[:billable]}
          type="checkbox"
          phx-click="toggle-billable"
          phx-target={@myself}
          label="Billable?"
        />

        <.input
          :if={@billable_activity?}
          field={@form[:business_partner_id]}
          type="select"
          label="Customer"
          placeholder="Customer"
          options={@business_partners}
        />

        <.input field={@form[:project_id]} type="select" label="Project" options={@projects} />

        <:actions>
          <.button phx-disable-with="Saving...">Save</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{timer: timer} = assigns, socket) do
    changeset = TimeTracking.change_timer(timer)

    socket =
      socket
      |> assign(assigns)
      |> assign(billable_activity?: assigns.timer.billable)
      |> assign_business_partner()
      |> assign_project()
      |> assign_form(changeset)

    {:ok, socket}
  end

  # @impl true
  # def handle_event("validate", %{"timer" => %{"tag_id" => "new"} = _timer_params}, socket) do
  #   # Launch new tag modal

  #   # Refresh list

  #   {:noreply, socket}
  # end

  def handle_event("toggle-billable", _params, socket) do
    billable_activity = !socket.assigns.billable_activity?

    _business_partner_id =
      case billable_activity do
        true -> socket.assigns.timer.business_partner_id
        false -> ""
      end

    socket =
      socket
      |> assign(billable_activity?: billable_activity)
      # |> assign(socket.assigns.timer.business_partner_id: business_partner_id)
      |> assign_business_partner()

    {:noreply, socket}
  end

  @impl true
  def handle_event("validate", %{"timer" => timer_params}, socket) do
    changeset =
      socket.assigns.timer
      |> TimeTracking.change_timer(timer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"timer" => timer_params}, socket) do
    save_timer(socket, socket.assigns.action, timer_params)
  end

  defp save_timer(socket, :edit, timer_params) do
    case TimeTracking.update_timer(socket.assigns.timer, timer_params) do
      {:ok, timer} ->
        notify_parent({:saved, timer})

        {:noreply,
         socket
         |> put_flash(:info, "Timer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_timer(socket, :new, timer_params) do
    case TimeTracking.create_timer(timer_params) do
      {:ok, timer} ->
        notify_parent({:saved, timer})

        {:noreply,
         socket
         |> put_flash(:info, "Timer created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  @spec assign_project(Phoenix.LiveView.Socket.t()) :: Klepsidra.Projects.Project.t()
  defp assign_project(socket) do
    projects =
      [
        {"", ""}
        | Projects.list_projects()
          |> Enum.map(fn project -> {project.name, project.id} end)
      ]

    assign(socket, projects: projects)
  end

  defp assign_business_partner(socket) do
    business_partners =
      case socket.assigns.billable_activity? do
        true ->
          [
            {"", ""}
            | BusinessPartners.list_business_partners()
              |> Enum.map(fn bp -> {bp.name, bp.id} end)
          ]

        _ ->
          [{"", ""}]
      end

    assign(socket, business_partners: business_partners)
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
