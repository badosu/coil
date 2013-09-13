# { :ok, pid } = :gen_server.start_link(ArticleServer, HashDict.new, [])
# :gen_server.cast(pid, b: 1)
# :gen_server.cast(pid, [:c, 1])
# :gen_server.call(pid, :b)

defmodule ArticleServer do
  use GenServer.Behaviour

  def handle_call(key, _from, config) do
    { :reply, config[key] , config }
  end

  def handle_cast([key, value], config) do
    { :noreply, HashDict.put(config, key, value) }
  end

  def handle_cast(keyvalue, config) do
    { :noreply, HashDict.merge(config, keyvalue) }
  end
end
