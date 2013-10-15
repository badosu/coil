defmodule Coil.Mixfile do
  use Mix.Project

  def project do
    [ app: :coil,
      version: "0.2.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ mod: { Coil, [] },
      registered: [ :cache_server ],
      applications: [:cowboy, :mimetypes, :ex_doc, :yamerl] ]
  end

  defp deps do
    [ { :cowboy,    github: "extend/cowboy" },
      { :mimetypes, github: "spawngrid/mimetypes" },
      { :ex_doc,    github: "elixir-lang/ex_doc" },
      { :yamerl,    github: "yakaz/yamerl" } ]
  end
end
