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
    {:ok, article_files} = File.ls("articles")

    Enum.map(article_files, &load_article/1)
  end

  def load_article(filename) do
    {:ok, article} = File.read("articles/#{filename}")

    meta = Regex.captures article_regex, filename

    if meta == nil do
      IO.puts :stderr, "Bad file: #{filename}"
    end

    [ content: article |> String.to_char_list! |> :markdown.conv,
      summary: article |> String.to_char_list! |> :markdown.conv,
      title: Keyword.get(meta, :title) |> String.capitalize
                                       |> String.replace("-", " "),
      path: Keyword.get(meta, :path),
      date: Keyword.get(meta, :date) ]
  end
end
