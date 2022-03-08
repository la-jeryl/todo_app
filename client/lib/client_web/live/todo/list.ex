defmodule ClientWeb.Live.Todo.List do
  use ClientWeb, :live_component

  def mount(socket) do
    {:ok, todo_list} = Todos.get_all_todos()
    {:ok, assign(socket, todos: todo_list)}
  end

  def render(assigns) do
    ~H"""
    <div class="live-todo-list">
      <%= for todo <- @todos do %>
        <div class="flex mb-4 items-center">
          <p class="todo-description-default">
            <%= todo.description %>
          </p>
          <button class="btn-done">Done</button>
          <button class="btn-remove">Remove</button>
        </div>
      <% end %>
    </div>
    """
  end
end
