defmodule Coil.Supervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link(__MODULE__, [])
    :gen_server.start_link({ :local, :cache_server }, CacheServer, HashDict.new, [])
  end

  def init([]) do
    children = [ worker(CacheServer, [HashDict.new]) ]
    supervise children, strategy: :one_for_one
  end
end
