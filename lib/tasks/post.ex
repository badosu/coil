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
      IO.write(file, "title: #{title}\n")
      IO.write(file, "date: #{date}\n")
      IO.write(file, "---\n")
    end)

    IO.puts(" Created #{filename}")
  end
end
