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

  # In read instruction the program recives this typle:
  # {:addi, 1, 1, 5},     # $1 <- 1 + 5 = 6
  # {:add, 4, 2, 1},      # $4 <- $2 + $1
  # {:addi, 5, 0, 1},     # $5 <- 0 + 1 = 1
  # :halt
  # The pc starts at 0 and jumps 4 for every instruction. Return the correct code segment with that index
  def read_instruction(code, pc) do
    Enum.at(code, div(pc, 4))
  end

  def load_word(data, index) do
    elem(data, index)
  end

  def store_word(data, index, value) do

  end
end
