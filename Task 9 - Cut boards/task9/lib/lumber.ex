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


  def costMemo([]) do {0, :na} end
  def costMemo(seq) do
    {cost, tree, _} = costMemo(seq, Memo.new())
    {cost, tree}
  end
  def costMemo([s], mem) do {0, s, mem} end
  def costMemo(seq, mem) do
    {c, t, mem} = costMemo(seq, 0, [], [], mem)
    {c, t, Memo.add(mem, seq, {c, t})}
  end
  def check(seq, mem) do
    case Memo.lookup(mem, seq) do
      nil ->
        costMemo(seq, mem)
      {c, t} ->
        {c, t, mem}
    end
  end
  def costMemo([], l, left, right, mem) do
    {costLeft, treeLeft, mem} = check(left, mem)
    {costRight, treeRight, mem} = check(right, mem)
    {costLeft + costRight + l, {treeLeft, treeRight}, mem}
  end
  def costMemo([s], l, left, [], mem) do
    {cost, tree, mem} = check(left, mem)
    {cost + s + l, {s, tree}, mem}
  end
  def costMemo([s], l, [], right, mem) do
    {cost, tree, mem} = check(right, mem)
    {cost + s + l, {tree, s}, mem}
  end
  def costMemo([s | rest], l, left, right, mem) do
    {costLeft, treeLeft, mem} = costMemo(rest, s + l, [s | left], right, mem)
    {costRight, treeRight, mem} = costMemo(rest, s + l, left, [s | right], mem)
    if costLeft < costRight do
      {costLeft + costRight + l, {treeLeft, treeRight}, mem}
    else
      {costRight + costLeft + l, {treeRight, treeLeft}, mem}
    end
  end
end
