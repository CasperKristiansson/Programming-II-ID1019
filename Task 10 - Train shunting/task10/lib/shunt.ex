defmodule Shunt do
  @doc """
  find that takes two trains xs and ys as input and returns
  a list of moves, such that the moves transform the state {xs,[],[]}
  into {ys,[],[]}.
  """
  def find(_, []) do [] end
  def find(xs, [y | ys]) do
    {hs, ts} = Processing.split(xs, y)

    moves = [
      {:one, 1 + Enum.count(ts)},
      {:two, Enum.count(hs)},
      {:one, -(1 + Enum.count(ts))},
      {:two, -(Enum.count(hs))}
    ]
    moves ++ find(hs, ys)
  end
end
