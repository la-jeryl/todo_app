defmodule Todos.Impl.Todo do
  import Ecto.Query, warn: false
  alias Todos.Repo
  alias Todos.Todo

  @type t :: %__MODULE__{
          priority: integer(),
          description: String.t(),
          is_done: boolean()
        }

  defstruct(
    priority: 0,
    description: "",
    is_done: false
  )

  ######################################################################

  @spec get_all_todos :: {:ok, Enum.t(__MODULE__.t())} | {:error, any}
  def get_all_todos do
    try do
      result =
        from(item in Todo, order_by: [asc: :priority])
        |> Repo.all()

      {:ok, result}
    catch
      error -> {:error, error}
    end
  end

  ######################################################################

  @spec get_todo_by_id(integer()) :: {:ok, any} | {:error, any}
  def get_todo_by_id(id) do
    try do
      result = Repo.get(Todo, id)

      with true <- result != nil do
        {:ok, result}
      else
        _ -> {:error, "Todo not found"}
      end
    catch
      error -> {:error, error}
    end
  end

  ######################################################################

  @spec get_todo_by_priority(integer()) :: {:ok, any} | {:error, any}
  def get_todo_by_priority(priority_value) do
    try do
      result = Repo.get_by(Todo, priority: priority_value)

      with true <- result != nil do
        {:ok, result}
      else
        _ -> {:error, "Todo not found"}
      end
    catch
      error -> {:error, error}
    end
  end

  ######################################################################

  @spec create_todo(__MODULE__.t()) :: {:ok, any} | {:error, any}
  def create_todo(todo) do
    try do
      result =
        with true <- Map.has_key?(todo, :priority),
             true <- Map.get(todo, :priority) != nil do
          # check if proposed priority value is within valid range
          proposed_priority_value = Map.get(todo, :priority)
          latest_todos_count = latest_todos_count()

          if proposed_priority_value in 1..latest_todos_count do
            # Could return {:ok, struct} or {:error, changeset}
            inserted_todo =
              %Todo{}
              |> Todo.changeset(todo)
              |> Repo.insert()

            {:ok, todo_details} = inserted_todo

            # move_todo does resetting of todo priorities
            move_todo(todo_details, proposed_priority_value)

            inserted_todo
          else
            {:error, "Assigned 'priority' is out of valid range"}
          end
        else
          _ ->
            # update the todo priority based on the latest count
            updated_todo_map = Map.put(todo, :priority, latest_todos_count())

            %Todo{}
            |> Todo.changeset(updated_todo_map)
            |> Repo.insert()
        end

      # Could return {:ok, struct} or {:error, changeset}
      result
    catch
      error -> {:error, error}
    end
  end

  ######################################################################

  @spec update_todo(__MODULE__.t(), MapSet.t()) :: {:ok, any} | {:error, any}
  def update_todo(todo, attrs) do
    try do
      result =
        with true <- Map.has_key?(attrs, :priority),
             true <- Map.get(attrs, :priority) != nil do
          # check if proposed priority value is within valid range
          proposed_priority_value = Map.get(attrs, :priority)
          current_record_count = current_todos_count()

          if proposed_priority_value in 1..current_record_count do
            # move_todo does resetting of todo priorities
            move_todo(todo, proposed_priority_value)

            # Could return {:ok, struct} or {:error, changeset}
            todo
            |> Todo.changeset(attrs)
            |> Repo.update()
          else
            {:error, "Assigned 'priority' is out of valid range"}
          end
        else
          _ ->
            todo
            |> Todo.changeset(attrs)
            |> Repo.update()
        end

      # Could return {:ok, struct} or {:error, changeset}
      result
    catch
      error -> {:error, error}
    end
  end

  ######################################################################

  @spec update_todo_by_priority(integer(), MapSet.t()) :: {:ok, any} | {:error, any}
  def update_todo_by_priority(priority, attrs) do
    try do
      {:ok, todo} = get_todo_by_priority(priority)

      # Could return {:ok, struct} or {:error, changeset}
      update_todo(todo, attrs)
    catch
      error -> {:error, error}
    end
  end

  ######################################################################

  @spec delete_todo(__MODULE__.t()) :: {:ok, any} | {:error, any}
  def delete_todo(todo) do
    try do
      result = Repo.delete(todo)

      {:ok, todo_list} = get_all_todos()
      reset_todos_priorities(todo_list)

      # Could return {:ok, struct} or {:error, changeset}
      result
    catch
      error -> {:error, error}
    end
  end

  ######################################################################

  @spec delete_todo_by_priority(integer()) :: {:ok, any} | {:error, any}
  def delete_todo_by_priority(priority) do
    try do
      {:ok, todo} = get_todo_by_priority(priority)

      # Could return {:ok, struct} or {:error, changeset}
      delete_todo(todo)
    catch
      error -> {:error, error}
    end
  end

  ######################################################################

  defp reset_todos_priorities(todo_list) do
    todo_list
    |> Enum.with_index(1)
    |> Enum.map(fn {item, index} ->
      item
      |> Todo.changeset(%{priority: index})
      |> Repo.update()
    end)
  end

  defp move_todo(%Todo{} = todo, proposed_priority_value) do
    {:ok, todo_list} = get_all_todos()

    current_todo_index = todo_list |> Enum.find_index(&(&1.id == todo.id))

    updated_todo_list = todo_list |> Enum.slide(current_todo_index, proposed_priority_value - 1)

    reset_todos_priorities(updated_todo_list)
  end

  defp latest_todos_count do
    current_todos_count() + 1
  end

  defp current_todos_count do
    from(item in Todo, select: count())
    |> Repo.one()
  end
end
