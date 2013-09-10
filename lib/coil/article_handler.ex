defmodule Coil.ArticleHandler do

  def handle(req, state) do
    article_template = EEx.compile_file("templates/article.html.eex")
    template = EEx.compile_file("templates/layout.html.eex")

    {path, _} = :cowboy_req.path(req)

    article = Coil.load_article("#{path |> Path.basename}.md")

    {article_result, _} = Code.eval_quoted(article_template, article)
    {result, _} = Code.eval_quoted(template, [
                    title: article[:title],
                    content: article_result])

    {:ok, req} = :cowboy_req.reply(200, [], result, req)

    {:ok, req, state}
  end

  def init(_transport, req, []), do: {:ok, req, nil}

  def terminate(_reason, _req, _state), do: :ok
end
