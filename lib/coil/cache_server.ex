defmodule CacheServer do
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
