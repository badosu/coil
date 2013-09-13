defmodule Coil.TopPageHandler do

  def handle(req, state) do
    index_result = Coil.template("index.html.eex", [articles: Coil.articles])
    result = Coil.template("layout.html.eex", [title: Coil.config("title"),
                                              content: index_result])

    {:ok, req} = :cowboy_req.reply(200, [], result, req)
    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok

end
