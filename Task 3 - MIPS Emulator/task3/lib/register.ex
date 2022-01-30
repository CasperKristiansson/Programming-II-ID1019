defmodule Register do
  @moduledoc """
    The register module should handle all operations for the
    registers: create a new register structure and, read and write to individual registers.
  """
  def new() do
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  end

  def read(_, 0) do 0 end
  def read(reg, index) do
    elem(reg, index)
  end

  def write(reg, 0, _) do reg end
  def write(reg, index, rs) do
    put_elem(reg, index, rs)
  end
end
