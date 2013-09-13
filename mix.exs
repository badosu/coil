defmodule Coil.Mixfile do
  use Mix.Project

  def project do
    [ app: :coil,
      version: "0.0.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ mod: { Coil, [] },
      registered: [ :cache_server ],
      applications: [:cowboy, :mimetypes, :markdown, :yamerl, :"elixir-datetime"] ]
  end

  defp deps do
    [ {:cowboy, github: "extend/cowboy"},
      {:mimetypes, github: "spawngrid/mimetypes"},
      {:markdown, github: "erlware/erlmarkdown", ref: "next" },
      {:"elixir-datetime", github: "alco/elixir-datetime"},
      {:yamerl, github: "yakaz/yamerl" } ]
  end
end
