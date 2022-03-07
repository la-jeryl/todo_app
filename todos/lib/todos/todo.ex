defmodule Todos.Todo do
  use Ecto.Schema

  schema "todos" do
    field(:priority, :integer)
    field(:description, :string)
    field(:is_done, :boolean, default: false)
  end

  def changeset(todo, params \\ %{}) do
    todo
    |> Ecto.Changeset.cast(params, [:priority, :description, :is_done])
    |> Ecto.Changeset.validate_required([:description])
  end
end
