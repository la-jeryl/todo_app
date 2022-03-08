defmodule ClientWeb.Live.Todo.List do
  use ClientWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="live-todo-list">
      <%= for todo <- assigns.todos do %>
        <div class="flex mb-4 items-center">
          <p class="todo-description-priority">
            <%= todo.priority %>)
          </p>
          <p class="todo-description-default">
            <%= todo.description %>
          </p>
          <button class="btn-done" phx-click="done-todo" phx-value-priority={todo.priority}>Done</button>
          <button class="btn-remove" phx-click="delete-todo" phx-value-priority={todo.priority}>Remove</button>
        </div>
      <% end %>
    </div>
    """
  end
end
