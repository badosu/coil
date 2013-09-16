defmodule Coil.ArticleHandler do

  def handle(req, state) do
    {path, _} = :cowboy_req.path(req)

    case Coil.article("#{path |> Path.basename}.md") do
      nil ->
        result = Coil.template("layout.html.eex", [
                        title: "Not found",
                        content: "<h1>Not Found</h1><p>Sorry :(</p>"])

        {:ok, req} = :cowboy_req.reply(404, [], result, req)
      article ->
        article_result = Coil.template("article.html.eex", article)
        result = Coil.template("layout.html.eex", [
                                title: article[:title],
                                content: article_result])

        {:ok, req} = :cowboy_req.reply(200, [], result, req)
    end

    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok
end
