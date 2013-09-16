defmodule Coil.RSSHandler do

  def handle(req, state) do
    articles = Coil.articles

    result = Coil.template("index.xml.eex", [
                           articles: articles,
                           last_updated: Enum.first(articles)[:date] ])

    {:ok, req} = :cowboy_req.reply(200,
                                   [{ "Content-Type", "application/rss+xml" }],
                                   result, req)
    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok

end
