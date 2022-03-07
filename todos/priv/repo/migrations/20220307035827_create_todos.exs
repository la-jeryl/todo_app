defmodule Todos.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :priority, :integer
      add :description, :string
      add :is_done, :boolean
    end
  end
end
