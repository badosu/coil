defmodule Coil.RSSHandler do

  def handle(req, state) do
    index = EEx.compile_file("templates/index.xml.eex")

    {result, _} = Code.eval_quoted(index, [
      articles: Coil.articles,
      last_updated: "2013-9-9",
    ])

    {:ok, req} = :cowboy_req.reply(200, [], result, req)
    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok

end
