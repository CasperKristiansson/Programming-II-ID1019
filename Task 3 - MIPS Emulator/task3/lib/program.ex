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

  def load_address([[]], _) do 0 end
  def load_address([[{:label, value}, {:word, address}] | tail], data) do
    if data == value do
      address
    else
      load_address(tail, data)
    end
  end

  def load_value([[]], _) do raise "Register Empty" end
  def load_value([[{:label, value}, {:word, address}] | tail], data) do
    if data == address do
      value
    else
      load_value(tail, data)
    end
  end

  def write(memory, address, value) do
    0 = rem(address, 4)
    memory ++ [[{:label, value}, {:word, address}]]
  end
end
