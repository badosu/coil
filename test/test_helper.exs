Code.require_file "../lib/coil.ex", __DIR__

File.cd "test"

defmodule TestHelper do

  def load_fixture(name) do
    File.read! "fixtures/#{name}"
  end

end

