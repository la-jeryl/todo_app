import Config

config :todos, Todos.Repo,
  database: "todos_repo",
  username: "jeryl",
  password: "testing",
  hostname: "localhost"

config :todos,
  ecto_repos: [Todos.Repo]
