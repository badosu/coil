defmodule Mix.Tasks.Coil do
  use Mix.Task

  def run(args) do
    case Enum.first(args) do
      nil -> IO.puts "You must specify a valid path"
      path ->
        if [:ok, {:error, :eexist}] |> Enum.member?(File.mkdir(path)) do
          File.ls!("example") |> Enum.each fn(file) ->
            File.cp_r("example/#{file}", path)
          end

          File.cp_r("deps", path)

          IO.puts "Blog created! Check #{path}"
        else
          IO.puts "You must specify a valid path"
        end
    end
  end
end
