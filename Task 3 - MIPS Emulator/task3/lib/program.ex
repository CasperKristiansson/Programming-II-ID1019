defmodule Program do
  @moduledoc """
    The module should be able to create a code segment and a
    data segment given a program description. It should provide functions
    to read from the code segment and both read and write to a data
    segment.
  """
  def load({:prgm, code, data}) do
    {
      {:code, code},
      {:data, data}
    }
  end

  def read_instruction(code, pc) do

  end
end
