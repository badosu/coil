defmodule Coil.RSSHandler do

  def handle(req, state) do
    result = Coil.template("index.xml.eex", [
      articles: Coil.articles,
      last_updated: "2013-9-9",
    ])

    {:ok, req} = :cowboy_req.reply(200, [], result, req)
    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok

end
