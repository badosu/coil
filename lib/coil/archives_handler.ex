defmodule Coil.ArchivesHandler do

  def handle(req, state) do
    articles = Coil.articles
    etag = (:cowboy_req.headers(req) |> elem 0)["if-none-match"]

    if List.first(articles)[:md5] == etag do
      {:ok, req} = :cowboy_req.reply(304, Coil.headers, "", req)
    else
      archives = Coil.template("archives.html.eex", [articles: articles])
      result = Coil.template("layout.html.eex", [
                                     title: "#{ Coil.config("title") } - Archives",
                                     content: archives])

      headers = Coil.headers |> Enum.concat [ {"ETag", List.first(articles)[:md5] } ]

      {:ok, req} = :cowboy_req.reply(200, headers, result, req)
    end

    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok

end
