defmodule Blog.Mixfile do
  use Mix.Project

  def project do
    [ app: :blog, version: "0.1.0",
      deps: [ {:coil, github: "badosu/coil"} ] ]
  end

  def application, do: [ mod: { Blog, [] }, applications: [:coil] ]
end

defmodule Blog do
  use Application.Behaviour

  def start(_, _), do: Blog.Supervisor.start_link
end

defmodule Blog.Supervisor do
  use Supervisor.Behaviour

  def start_link, do: :supervisor.start_link(__MODULE__, [])

  def init([]) do
    children = [ ]
    supervise children, strategy: :one_for_one
  end
end
