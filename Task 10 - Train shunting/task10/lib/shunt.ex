defmodule Shunt do
  @doc """
  Finding moves to rearange wagons in xs to get ys.
  """
  def find(_, []) do [] end
  def find([], _) do [] end
  def find(xs, [y | ys]) do
    {hs, ts} = Processing.split(xs, y)

    moves = [
      {:one, 1 + Enum.count(ts)},
      {:two, Enum.count(hs)},
      {:one, -(1 + Enum.count(ts))},
      {:two, -(Enum.count(hs))}
    ]

    moves ++ find(hs ++ ts, ys)
  end

  def few(_, []) do [] end
  def few([], _) do [] end
  def few(xs, [y | ys]) do
    {hs, ts} = Processing.split(xs, y)

    moves = [
      {:one, 1 + Enum.count(ts)},
      {:two, Enum.count(hs)},
      {:one, -(1 + Enum.count(ts))},
      {:two, -(Enum.count(hs))}
    ]

    if Enum.count(hs) == 0 do
      [] ++ few(ts, ys)
    else
      moves ++ few(hs ++ ts, ys)
    end
  end
end
