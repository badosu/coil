defmodule Coil.Supervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link(__MODULE__, [])
    :gen_server.start_link({ :local, :article_server }, ArticleServer, HashDict.new, [])
  end

  def init([]) do
    children = [ worker(ArticleServer, [HashDict.new]) ]
    supervise children, strategy: :one_for_one
  end
end
