defmodule Coil.RSSHandler do

  def handle(req, state) do
    index = EEx.compile_file("templates/index.xml.eex")

    {:ok, article_files} = File.ls("articles")

    articles = Enum.map(article_files, &Coil.load_article/1)

    {result, _} = Code.eval_quoted(index, [
      articles: articles,
      title: "Badosu's blog",
      host: "http://google.com",
      author: "Amadeus Folego",
      last_updated: "2013-9-9",
    ])

    {:ok, req} = :cowboy_req.reply(200, [], result, req)
    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok

end
