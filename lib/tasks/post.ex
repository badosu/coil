defmodule Mix.Tasks.Post do
  use Mix.Task

  def run(_) do
    title = IO.gets(" What's the title of your post?\n -  ") |>
            String.strip

    downcased = title |> String.downcase
                      |> String.replace(" ", "-")

    {{year, month, day}, _} = Date.now |> Date.local

    date = "#{year}-#{month}-#{day}"
    filename = "articles/#{date}-#{downcased}.md"

    File.open(filename, [:write], fn(file) ->
      IO.write(file, "Contents of the post")
    end)

    IO.puts(" Please edit #{filename}")
  end
end
