defmodule Coil.RSSHandler do

  def handle(req, state) do
    articles = Coil.articles
    etag = (:cowboy_req.headers(req) |> elem 0)["if-none-match"]

    if Enum.first(articles)[:md5] == etag do
      {:ok, req} = :cowboy_req.reply(304, [], "", req)
    else
      result = Coil.template("index.xml.eex", [
                             articles: articles,
                             last_updated: Enum.first(articles)[:date] ])

      headers = [ {"ETag", Enum.first(articles)[:md5] },
                  {"Content-Type", "application/rss+xml" } ]

      {:ok, req} = :cowboy_req.reply(200, headers, result, req)
    end

    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok

end
