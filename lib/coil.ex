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
    File.ls!("articles") |> Enum.map(&load_article/1)
  end

  def load_article(filename) do
    if File.exists?("tmp/cache/#{filename}") do
      article = File.read!("tmp/cache/#{filename}")
      content = article
      summary = article
    else
      article = File.read!("articles/#{filename}")
      content = article |> String.to_char_list! |> :markdown.conv
      summary = article |> String.to_char_list! |> :markdown.conv
      cache_article(filename, content)
    end

    meta = Regex.captures article_regex, filename

    if meta == nil do
      IO.puts :stderr, "Bad file: #{filename}"
    end

    [ content: content,
      summary: summary,
      title: meta[:title] |> String.capitalize |> String.replace("-", " "),
      path: meta[:path],
      date: meta[:date] ]
  end

  def config do
    :yamerl_constr.file("config.yml") |> List.flatten
  end

  def config(key) do
    config[String.to_char_list!(key)] |> String.from_char_list!
  end

  def cache_article(filename, article) do
    File.write("tmp/cache/#{filename}", article)
  end
end
