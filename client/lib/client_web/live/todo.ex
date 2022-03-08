defmodule ClientWeb.Live.Todo do
  use ClientWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, fetch(socket)}
  end

  def handle_event("create-todo", %{"todo" => todo}, socket) do
    Todos.create_todo(todo)
    {:noreply, fetch(socket)}
  end

  def handle_event("delete-todo", %{"priority" => priority}, socket) do
    IO.inspect(priority)
    Todos.delete_todo_by_priority(priority)
    {:noreply, fetch(socket)}
  end

  def render(assigns) do
    ~H"""
    <div class="self-center h-100 w-full flex items-center justify-center font-sans">
      <div class="section-main">
        <.live_component module={__MODULE__.Input} id="todo-input" todos={assigns.todos} />
        <.live_component module={__MODULE__.List} id="todo-list" todos={assigns.todos} />
      </div>
    </div>
    """
  end

  defp fetch(socket) do
    {:ok, todo_list} = Todos.get_all_todos()
    assign(socket, todos: todo_list)
  end
end
