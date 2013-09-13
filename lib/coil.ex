defmodule Coil do
  use Application.Behaviour

  def start(_type, _args) do
    dispatch = :cowboy_router.compile([
                 {:_, [
                        {"/", Coil.TopPageHandler, []},
                        {"/public/[:...]", :cowboy_static, [
                             directory: "public",
                             mimetypes: { &:mimetypes.path_to_mimes/2, :default } ] },
                        {"/index.xml", Coil.RSSHandler, []},
                        {"/archives", Coil.ArchivesHandler, []},
                        {"/[:...]", Coil.ArticleHandler, []}
                      ]}
               ])

    port = binary_to_integer(System.get_env("PORT") || "8080")

    {:ok, _} = :cowboy.start_http(:http, 100,
                                  [port: port],
                                  [env: [dispatch: dispatch]])

    Coil.Supervisor.start_link
  end

  def article_regex, do: %r/(?<path>(?<date>\w{4}-\w\w?-\w\w?)-(?<title>[\w-]+))/g

  def articles do
    File.ls!("articles") |> Enum.map(&article/1)
  end

  def article(filename) do
    article = :gen_server.call(:cache_server, "articles/#{filename}")

    if article == nil, do: article = load_article(filename)

    article
  end

  def template(filename) do
    template = :gen_server.call(:cache_server, "templates/#{filename}")

    if template == nil, do: template = load_template(filename)

    template
  end

  def template(filename, keys) do
    {result, _} = Code.eval_quoted(template(filename), keys)

    result
  end

  def config do
    :yamerl_constr.file("config.yml") |> List.flatten
  end

  def config(key) do
    config[String.to_char_list!(key)] |> String.from_char_list!
  end

  defp load_template(template) do
    filename = "templates/#{template}"
    case File.read(filename) do
      {:ok, template} ->
        result = EEx.compile_file(filename)
        :gen_server.cast(:cache_server, [filename, result])

        result
      {:error, :enoent} ->
        IO.puts :stderr, "Does not exist: #{filename}"
        nil
      other ->
        IO.puts :stderr, "Bad file: #{filename}. Reason: #{ inspect other }"
        nil
    end
  end

  defp load_article(article) do
    filename = "articles/#{article}"
    case File.read(filename) do
      {:ok, article} ->
        content = article |> String.to_char_list! |> :markdown.conv
        summary = article |> String.to_char_list! |> :markdown.conv

        meta = Regex.captures article_regex, filename

        if meta == nil do
          IO.puts :stderr, "Bad file: #{filename}"
        end

        result = [ content: content,
          summary: summary,
          title: meta[:title] |> String.capitalize |> String.replace("-", " "),
          path: meta[:path],
          date: meta[:date] ]

        :gen_server.cast(:cache_server, [filename, result])

        result
      {:error, :enoent} ->
        IO.puts :stderr, "Does not exist: #{filename}"
        nil
      other ->
        IO.puts :stderr, "Bad file: #{filename}. Reason: #{ inspect other }"
        nil
    end
  end
end
