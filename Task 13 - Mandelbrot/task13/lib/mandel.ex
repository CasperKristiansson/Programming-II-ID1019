defmodule Mandel do
  @moduledoc """
  """

  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
      Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end

    rows(width, height, trans, depth, [])
  end

  def rows(_, 0, _, _, rows), do: rows
  def rows(width, height, trans, depth, rows) do
    row = row(width, height, trans, depth, [])
    rows(width, height - 1, trans, depth, [row | rows])
  end

  def row(0, _, _, _, row), do: row
  def row(width, height, trans, depth, row) do
    complex = trans.(width, height)
    calculation = Brot.mandelbrot(complex, depth)

    color = Color.convert(calculation, depth)
    row(width - 1, height, trans, depth, [color | row])
  end
end
