defmodule Cmplx do
  @moduledoc """
  """

  @doc """
  returns the complex number with real value r and imaginary i.
  For this task the complex number will be reprsented as a tuple. But elixir
  already supports Complex.new(3, 4)
  """
  def new(r, i) do
    {r, i}
  end

  @doc """
  adds two complex numbers
  """
  def add({r1, i1}, {r2, i2}) do
    {r1 + r2, i1 + i2}
  end

  @doc """
  squares a complex number
  Formula:
  (a + bi)^2 = a^2 + 2ab + (bi)^2 =
  a^2 + 2ab + b^2 * i^2 =
  a^2 − b^2 + 2abi =
  (a^2 − b^2) + (2ab)i
  """
  def sqr({r, i}) do
    {r * r - i * i, 2 * r * i}
  end

  @doc """
  the absolute value of a
  |z|^2 = x^2 + y^2
  """
  def abs({r, i}) do
    :math.sqrt(r * r + i * i)
  end
end
