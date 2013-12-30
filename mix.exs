defmodule Coil.Mixfile do
  use Mix.Project

  def project do
    [ app: :coil,
      version: "0.4.0",
      deps: deps ]
  end

  def application do
    [ mod: { Coil, [] },
      registered: [ :cache_server ],
      applications: [:cowboy, :ex_doc, :yamerl] ]
  end

  defp deps do
    [ { :cowboy,    github: "extend/cowboy" },
      { :ex_doc,    github: "elixir-lang/ex_doc" },
      { :yamerl,    github: "yakaz/yamerl" } ]
  end
end
