defmodule Brot do
  @moduledoc """
  """

  @doc """
  Implement a function mandelbrot/2 that, given the complex number
  c and the maximum number of iterations m, return the value i at which
  |zi| > 2 or 0 if it does not for any i < m i.e. it should always return a value
  in the range 0..(m − 1).
  """
  def mandelbrot(c, m) do
    z0 = Cmplx.new(0, 0)
    test(0, z0, c, m)
  end

  def test(i, _, _, m) when i >= m, do: 0
  def test(i, z, c, m) do
    if Cmplx.abs(z) < 2 do
      z = Cmplx.add(Cmplx.sqr(z), c)
      test(i + 1, z, c, m)
    else
      i
    end
  end
end
