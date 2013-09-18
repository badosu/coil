defmodule CoilBlog.Mixfile do
  use Mix.Project

  def project do
    [ app: :coilblog, version: "0.1.0",
      deps: [ {:coil, github: "badosu/coil"} ] ]
  end

  def application, do: [ mod: { CoilBlog, [] }, applications: [:coil] ]
end

defmodule CoilBlog do
  use Application.Behaviour

  def start(_, _), do: CoilBlog.Supervisor.start_link
end

defmodule CoilBlog.Supervisor do
  use Supervisor.Behaviour

  def start_link, do: :supervisor.start_link(__MODULE__, [])

  def init([]) do
    children = [ ]
    supervise children, strategy: :one_for_one
  end
end
