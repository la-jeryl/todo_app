defmodule ClientWeb.Live.Todo.Input do
  use ClientWeb, :live_component

  def mount(socket) do
    {:ok, todo_list} = Todos.get_all_todos()
    {:ok, assign(socket, todos: todo_list)}
  end

  def render(assigns) do
    ~H"""
    <div class="live-todo-input">
      <div class="mb-4">
        <div class="flex mt-4">
          <input class="input-todo"
            placeholder="Add Todo">
          <button
            class="btn-add">Add</button>
        </div>
      </div>
    </div>
    """
  end
end
