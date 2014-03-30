defmodule Mix.Tasks.Coil do
  use Mix.Task

  def run(args) do
    case List.first(args) do
      nil -> IO.puts "You must specify a valid path"
      path ->
        if [:ok, {:error, :eexist}] |> Enum.member?(File.mkdir(path)) do
          File.cp_r("example", path)

          IO.puts """

Blog structure created!

  Run 'cd #{path}; mix deps.get' to fetch dependencies
  Then you can simply run 'PORT=8080 mix run --no-halt' to start the server
"""
        else
          IO.puts "You must specify a valid path"
        end
    end
  end
end
