defmodule ClientWeb.Live.Todo do
  use ClientWeb, :live_view

  def(mount(_params, _session, socket)) do
    {:ok, fetch(socket)}
  end

  def handle_event("create-todo", %{"todo" => todo}, socket) do
    todo
    |> key_to_atom()
    |> Todos.create_todo()

    {:noreply, fetch(socket)}
  end

  def handle_event("delete-todo", %{"priority" => priority}, socket) do
    Todos.delete_todo_by_priority(priority)
    {:noreply, fetch(socket)}
  end

  def handle_event("done-todo", %{"priority" => priority}, socket) do
    Todos.update_todo_by_priority(priority, %{is_done: false})

    {:noreply, fetch(socket)}
  end

  def handle_event("not-done-todo", %{"priority" => priority}, socket) do
    Todos.update_todo_by_priority(priority, %{is_done: true})
    {:noreply, fetch(socket)}
  end

  def render(assigns) do
    ~H"""
    <div class="self-center h-100 w-full flex items-center justify-center font-sans">
      <div class="section-main">
        <.live_component module={__MODULE__.Input} id="todo-input" />
        <.live_component module={__MODULE__.List} id="todo-list" todos={assigns.todos} />
      </div>
    </div>
    """
  end

  defp fetch(socket) do
    {:ok, todo_list} = Todos.get_all_todos()
    assign(socket, todos: todo_list)
  end

  defp key_to_atom(map) do
    Enum.reduce(map, %{}, fn
      # String.to_existing_atom saves us from overloading the VM by
      # creating too many atoms. It'll always succeed because all the fields
      # in the database already exist as atoms at runtime.
      {key, value}, acc when is_atom(key) -> Map.put(acc, key, value)
      {key, value}, acc when is_binary(key) -> Map.put(acc, String.to_existing_atom(key), value)
    end)
  end
end
