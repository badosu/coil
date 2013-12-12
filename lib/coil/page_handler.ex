defmodule Coil.PageHandler do
  def handle(req, state) do
    {path, _} = :cowboy_req.path(req)

    case Coil.page("#{path |> Path.basename}.md") do
      nil ->
        result = Coil.template("layout.html.eex", [
                        title: "Not found",
                        content: "<h1>Not Found</h1><p>Sorry :(</p>"])

        {:ok, req} = :cowboy_req.reply(404, Coil.headers, result, req)
      page ->
        etag = (:cowboy_req.headers(req) |> elem 0)["if-none-match"]

        if page[:md5] == etag do
          {:ok, req} = :cowboy_req.reply(304, [], "", req)
        else
          page_result = Coil.template("page.html.eex", page)
          result = Coil.template("layout.html.eex", [
                                  title: page[:title],
                                  content: page_result])

          headers = Coil.headers |> Enum.concat [{"ETag", page[:md5]}]

          {:ok, req} = :cowboy_req.reply(200, headers, result, req)
        end
    end

    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok
end
