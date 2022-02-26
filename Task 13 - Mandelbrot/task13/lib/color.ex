defmodule Color do
  @moduledoc """
  """

  def convert(depth, max) do
    a = (depth / max) * 4
    x = trunc(a)
    y = trunc(255 * (a - x))

    blue_purple(x, y)
  end

  def blue_purple(x, y) do
    case x do
      0 ->
        cond do
          y < 85 ->
            {0, 0, y}
          y < 120 ->
            {y - 85, 0, 255}
          y < 170 ->
            {y - 80, 0, 255}
          true ->
            {155, 0, 255 - y}
        end
      1 ->
        {35, 175, y}
      2 ->
        {255 - y, 255, 0}
      3 ->
        {0, 255, y}
      4 ->
        {0, 255 - y, 255}
    end
  end

  def blue_green(x, y) do
    case x do
      0 ->
        cond do
          y < 85 ->
            {0, 0, y}
          y < 120 ->
            {0, y - 85, 255}
          y < 170 ->
            {0, y - 80, 255}
          true ->
            {0, 155, 255 - y}
        end
      1 ->
        {35, 175, y}
      2 ->
        {0, 255, 255-y}
      3 ->
        {0, 255, y}
      4 ->
        {0, 255 - y, 255}
    end
  end

  def red(x, y) do
    case x do
      0 ->
        cond do
          y < 85 ->
            {y, 0, 0}
          y < 120 ->
            {255, y - 85, 0}
          y < 170 ->
            {255, y - 80, 0}
          true ->
            {255 - y, 155, 0}
        end
      1 ->
        {255, y, 0}
      2 ->
        {255 - y, 255, 0}
      3 ->
        {0, 255, y}
      4 ->
        {0, 255 - y, 255}
    end
  end

  def blue(x, y) do
    case x do
      0 ->
        {0, 0, y}
      1 ->
        {0, y, 255}
      2 ->
        {0, 255, 255 - y}
      3 ->
        {y, 255, 0}
      4 ->
        {255, 255 - y, 0}
    end
  end
end
