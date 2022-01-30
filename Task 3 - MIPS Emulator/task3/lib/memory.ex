defmodule Memory do
  def new() do
    {}
  end

  def load(memory, address) do
    Map.fetch(memory, address)
  end
end
