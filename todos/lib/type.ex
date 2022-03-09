defmodule Todos.Type do
  @type todo :: %{
          priority: integer(),
          description: String.t(),
          is_done: boolean()
        }
end
