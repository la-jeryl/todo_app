defmodule Todos do
  @moduledoc """
  Documentation for `Todos`.
  """

  alias Todos.Impl.Todo

  @opaque todo :: Todo.t()

  @doc """
  Create a new todo.

  ## Examples

      iex> Todos.create_todo(%{
          description: "writing a book"
        })
      : {:ok, %{description: "writing a book", is_done: false, priority: 6}}
  """
  @spec create_todo(todo()) :: {:ok, todo} | {:error, any}
  defdelegate create_todo(todo), to: Todo

  @doc """
  Get a todo based on priority.

  ## Examples

      iex> Todos.get_todo_by_priority(6)
      : {:ok, %{description: "writing a book", is_done: false, priority: 6}}
  """
  @spec get_todo_by_priority(integer()) :: {:ok, todo} | {:error, any}
  defdelegate get_todo_by_priority(priority), to: Todo

  @doc """
  Get all todos.

  ## Examples

      iex> Todos.get_all_todos
      : {:ok,
        [
          %{description: "eat midnight snacks :) ", is_done: false, priority: 1},
          %{description: "orange", is_done: false, priority: 2},
          %{description: "hello", is_done: false, priority: 3},
          %{description: "ride a bike", is_done: false, priority: 4},
          %{description: "eat apple", is_done: false, priority: 5}
        ]}
  """
  @spec get_all_todos :: {:ok, Enum.t(todo())} | {:error, any}
  defdelegate get_all_todos, to: Todo

  @doc """
  Update a todo based on priority.

  ## Examples

      iex> Todos.update_todo_by_priority( 6, %{description: "eat healthy food", priority: 1})
      : {:ok, %{description: "eat healthy food", is_done: false, priority: 1}}
  """
  @spec update_todo_by_priority(integer(), MapSet.t()) :: {:ok, todo} | {:error, any}
  defdelegate update_todo_by_priority(priority, attrs), to: Todo

  @doc """
  Delete a todo based on priority.

  ## Examples

      iex> Todos.delete_todo_by_priority(2)
      : {:ok, %{description: "eat apple", is_done: false, priority: 2}}
  """
  @spec delete_todo_by_priority(integer()) :: {:ok, todo} | {:error, any}
  defdelegate delete_todo_by_priority(priority), to: Todo
end
