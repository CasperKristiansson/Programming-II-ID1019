defmodule Lumber do
  def split(seq) do split(seq, 0, [], []) end
  def split([], l, left, right) do
    [{left, right, l}]
  end
  def split([s | rest], l, left, right) do
    split(rest, s + l, [s | left], right) ++ split(rest, s + l, left, [s | right])
  end


  def cost([]) do 0 end
  def cost([_]) do 0 end
  def cost(seq) do cost(seq, 0, [], []) end
  def cost([], l, left, right) do
    cost(left) + cost(right) + l
  end
  def cost([s], l, [], right) do
    cost(right) + s + l
  end
  def cost([s], l, left, []) do
    cost(left) + s + l
  end
  def cost([s | rest], l, left, right) do
    costLeft = cost(rest, s + l, [s | left], right)
    costRight = cost(rest, s + l, left, [s | right])
    if costLeft < costRight do
      costLeft
    else
      costRight
    end
  end
end
