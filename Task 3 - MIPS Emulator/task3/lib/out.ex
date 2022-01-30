defmodule Out do
  @moduledoc """
    The module should collect the output from the execution and
    be able to return it as a list of integers.
  """
  def new() do [] end

  def close(out) do Enum.reverse(out) end

  def put(out, s) do [s | out] end
end
