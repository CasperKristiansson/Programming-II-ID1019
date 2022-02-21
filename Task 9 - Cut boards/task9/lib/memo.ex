defmodule Memo do
  def new() do %{} end
  def add(mem, key, val) do Map.put(mem, key, val) end
  def lookup(mem, key) do Map.get(mem, key) end
end
