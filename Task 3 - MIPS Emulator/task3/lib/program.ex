defmodule Program do
  @moduledoc """
    The module should be able to create a code segment and a
    data segment given a program description. It should provide functions
    to read from the code segment and both read and write to a data
    segment.
  """
  def load({:prgm, code, data}) do
    { code, data }
  end

  def read_instruction(code, pc) do
    Enum.at(code, div(pc, 4))
  end

  def read_value(memory, address) do
    Tree.tree_lookup(address, memory)
  end

  def read_address(memory, value) do
    Tree.tree_traverse(value, memory)
  end

  def write(memory, address, value) do
    Tree.tree_insert(address, value, memory)
  end
end
