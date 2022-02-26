defmodule Color do
  @moduledoc """
  """

  def convert(depth, max) do
    a = (depth / max) * 4.0
    255.0 * (a - trunc(a))
  end
end
