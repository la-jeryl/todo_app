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
      : {:ok,
        %Todos.Todo{
          __meta__: #Ecto.Schema.Metadata<:loaded, "todos">,
          description: "writing a book",
          id: 11,
          is_done: false,
          priority: 7
        }}
  """
  @spec create_todo(todo()) :: {:ok, todo} | {:error, any}
  defdelegate create_todo(todo), to: Todo

  @doc """
  Get a todo based on its priority.

  ## Examples

      iex> Todos.get_todo_by_priority(7)
      : {:ok,
        %Todos.Todo{
          __meta__: #Ecto.Schema.Metadata<:loaded, "todos">,
          description: "writing a book",
          id: 11,
          is_done: false,
          priority: 7
        }}
  """
  @spec get_todo_by_priority(integer()) :: {:ok, todo} | {:error, any}
  defdelegate get_todo_by_priority(priority), to: Todo

  @doc """
  Get all todos.

  ## Examples

      iex> Todos.get_all_todos
      : {:ok,
        [
          %Todos.Todo{
            __meta__: #Ecto.Schema.Metadata<:loaded, "todos">,
            description: "testing",
            id: 13,
            is_done: false,
            priority: 1
          },
          %Todos.Todo{
            __meta__: #Ecto.Schema.Metadata<:loaded, "todos">,
            description: "writing code",
            id: 12,
            is_done: false,
            priority: 2
          }
        ]}
  """
  @spec get_all_todos :: {:ok, Enum.t(todo())} | {:error, any}
  defdelegate get_all_todos, to: Todo

  @doc """
  Update a todo.

  ## Examples

      iex> Todos.update_todo(todo, %{
          description: "ride my road bike",
          priority: 1
        })
      : {:ok,
        %Todos.Todo{
          __meta__: #Ecto.Schema.Metadata<:loaded, "todos">,
          description: "eat breakfast",
          id: 11,
          is_done: false,
          priority: 1
        }}
  """
  @spec update_todo(todo(), MapSet.t(todo())) :: {:ok, todo} | {:error, any}
  defdelegate update_todo(todo, attrs), to: Todo

  @doc """
  Delete a todo based on priority.

  ## Examples

      iex> Todos.delete_todo_by_priority(7)
      : {:ok,
        %Todos.Todo{
          __meta__: #Ecto.Schema.Metadata<:deleted, "todos">,
          description: "apple",
          id: 21,
          is_done: false,
          priority: 10
        }}
  """
  @spec delete_todo_by_priority(integer()) :: {:ok, todo} | {:error, any}
  defdelegate delete_todo_by_priority(priority), to: Todo
end
