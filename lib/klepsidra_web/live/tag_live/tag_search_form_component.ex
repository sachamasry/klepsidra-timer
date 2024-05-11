defmodule KlepsidraWeb.Live.TagLive.SearchFormComponent do
  @moduledoc false

  use KlepsidraWeb, :live_component
  alias Klepsidra.Categorisation
  alias Klepsidra.Categorisation.Tag
  alias Klepsidra.TimeTracking

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="tag-search my-6">
      <form phx_change="tag_search" phx-trigger-action={false} phx-target={@myself}>
        <div
          class="py-2 px-3 bg-white border border-gray-400"
          phx-window-keydown="set-focus"
          phx-target={@myself}
        >
          <span
            :for={timer_tag <- @timer_tags}
            class="inline-block text-xs bg-green-400 text-white py-1 px-2 mr-2 mb-1 rounded font-semibold"
            style={if timer_tag.tag.colour, do: "background-color:" <> timer_tag.tag.colour}
          >
            <span><%= timer_tag.tag.name %></span>
            <a
              href="#"
              class="text-white hover:text-white pl-1"
              phx-click="delete"
              phx-target={@myself}
              phx-value-timer-tag-id={timer_tag.id}
            >
              &times;
            </a>
          </span>

          <input
            type="text"
            class="form-control inline-block text-sm focus:outline-none"
            name="search_phrase"
            value={@search_phrase}
            placeholder="Enter tag"
            autocomplete="off"
            phx-change="tag_search"
            phx-debounce="500"
          />
        </div>

        <div :if={@search_results != []} class="relative">
          <div class="absolute z-50 left-0 right-0 rounded border border-gray-100 shadow py-1 bg-white">
            <div
              :for={{{_id, tag_name, tag_colour}, idx} <- Enum.with_index(@search_results)}
              class={"cursor-pointer p-2 hover:bg-gray-200 focus:bg-gray-200 #{if(idx == @current_focus, do: "bg-gray-200")}"}
              phx-click="pick"
              phx-target={@myself}
              phx-value-name={tag_name}
            >
              <span style="display: inline-block; width: calc(100% - (1.2rem + 1.5rem));">
                <%= raw(format_search_result(tag_name, @search_phrase)) %>
              </span>
              <span style={"display: inline-block; height: 1.2rem; width: 1.2rem; border-radius: 20%; background-color: #{tag_colour || "transparent"};"}>
              </span>
            </div>
          </div>
        </div>
      </form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    timer = TimeTracking.get_timer!(assigns.timer_id) |> Klepsidra.Repo.preload(:tags)

    changeset = Categorisation.change_tag(%Tag{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(
       timer: timer,
       timer_tags: sort_tags(timer.timer_tags),
       tags: [],
       search_results: [],
       search_phrase: "",
       current_focus: -1,
       form: to_form(changeset)
     )}
  end

  @impl true
  def handle_event("tag_search", %{"search_phrase" => search_phrase}, socket) do
    tags = if socket.assigns.tags == [], do: Categorisation.list_tags(), else: socket.assigns.tags

    search_results =
      Klepsidra.Categorisation.search_tags_by_name_prefix(search_phrase)
      |> Enum.map(fn tag -> {tag.id, tag.name, tag.colour} end)

    socket =
      assign(socket,
        tags: tags,
        search_results: search_results,
        search_phrase: search_phrase
      )

    {:noreply, socket}
  end

  def handle_event("pick", %{"name" => search_phrase}, socket) do
    timer = add_tag_to_timer(socket.assigns.timer, search_phrase)

    assigns = [
      timer_tags: sort_tags(timer.timer_tags),
      tags: [],
      search_results: [],
      search_phrase: ""
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("delete", %{"timer-tag-id" => timer_tag_id}, socket) do
    delete_tag_from_timer(timer_tag_id)

    timer_tags =
      socket.assigns.timer_tags
      |> Enum.reject(fn i -> i.id == String.to_integer(timer_tag_id) end)

    assigns = [
      timer_tags: timer_tags,
      tags: [],
      search_results: [],
      search_phrase: ""
    ]

    {:noreply, assign(socket, assigns)}
  end

  # PREVENT FORM SUBMIT
  # def handle_event("submit", _, socket), do: {:noreply, socket}

  # UP
  def handle_event("set-focus", %{"key" => "ArrowUp"}, socket) do
    current_focus =
      Enum.max([socket.assigns.current_focus - 1, 0])

    socket =
      assign(socket, current_focus: current_focus)

    {:noreply, socket}
  end

  # DOWN
  def handle_event("set-focus", %{"key" => "ArrowDown"}, socket) do
    current_focus =
      Enum.min([socket.assigns.current_focus + 1, length(socket.assigns.search_results) - 1])

    socket =
      assign(socket, current_focus: current_focus)

    {:noreply, socket}
  end

  # ENTER
  def handle_event("set-focus", %{"key" => "Enter"}, socket) do
    search_phrase =
      case Enum.at(socket.assigns.search_results, socket.assigns.current_focus) do
        {_, "" <> search_phrase} -> handle_event("pick", %{"name" => search_phrase}, socket)
        _ -> socket.assigns.search_phrase
      end

    handle_event("pick", %{"name" => search_phrase}, socket)
  end

  # FALLBACK FOR NON RELATED KEY STROKES
  def handle_event("set-focus", _, socket), do: {:noreply, socket}

  def format_search_result(search_result, search_phrase) do
    split_at = String.length(search_phrase)
    {selected, rest} = String.split_at(search_result, split_at)

    "<strong>#{selected}</strong>#{rest}"
  end

  defp add_tag_to_timer(timer, search_phrase) do
    Categorisation.tag_timer(timer, %{tag: %{name: search_phrase}})
    timer = TimeTracking.get_timer!(timer.id) |> Klepsidra.Repo.preload(:tags)

    # timer.tags
    timer
  end

  defp delete_tag_from_timer(timer_tag_id) do
    {:ok, timer_tag} =
      timer_tag_id
      |> Categorisation.get_timer_tag!()
      |> Categorisation.delete_timer_tag()

    timer_tag
  end

  defp sort_tags(timer_tags) do
    Enum.sort_by(timer_tags, fn tag -> tag.id end)
  end
end
