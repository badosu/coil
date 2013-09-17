defmodule Mix.Tasks.Post do
  use Mix.Task

  def run(_) do
    title = IO.gets(" What's the title of your post?\n -  ") |>
            String.strip

    downcased = title |> String.downcase
                      |> String.replace(" ", "-")

    {{year, month, day}, _} = :calendar.local_time

    date = "#{year}-#{pad(month)}-#{pad(day)}"
    filename = "articles/#{date}-#{downcased}.md"

    File.open(filename, [:write], fn(file) ->
      IO.write(file, "Contents of the post")
    end)

    IO.puts(" Please edit #{filename}")
  end

  defp pad(number) when number < 10 do
    "0" <> integer_to_binary(number)
  end

  defp pad(number) do
    integer_to_binary(number)
  end
end
