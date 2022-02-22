defmodule Basic do
  @moduledoc """

  """
  def split(seq) do split(seq, 0, [], []) end
  def split([], l, left, right) do
    [{left, right, l}]
  end
  def split([s | rest], l, left, right) do
    split(rest, s + l, [s | left], right) ++ split(rest, s + l, left, [s | right])
  end
end

defmodule SolutionOne do
  @moduledoc """

  """
  def cost([]) do 0 end
  def cost([s]) do {0, s} end
  def cost(seq) do cost(seq, 0, [], []) end
  def cost([], l, left, right) do
    {costLeft, treeLeft} = cost(left)
    {costRight, treeRight} = cost(right)
    {costLeft + costRight + l, {treeLeft, treeRight}}
  end
  def cost([s], l, [], right) do
    {costRight, treeRight} = cost(right)
    {costRight + l + s, {s, treeRight}}
  end
  def cost([s], l, left, []) do
    {costLeft, treeLeft} = cost(left)
    {costLeft + l + s, {s, treeLeft}}
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

defmodule SolutionTwo do
  @moduledoc """

  """
  def cost([]) do {0, :na} end
  def cost(seq) do
    {cost, tree, _} = cost(seq, Memo.new())
    {cost, tree}
  end
  def cost([s], mem) do {0, s, mem} end
  def cost(seq, mem) do
    {c, t, mem} = cost(seq, 0, [], [], mem)
    {c, t, Memo.add(mem, seq, {c, t})}
  end
  def check(seq, mem) do
    case Memo.lookup(mem, seq) do
      nil ->
        cost(seq, mem)
      {c, t} ->
        {c, t, mem}
    end
  end
  def cost([], l, left, right, mem) do
    {costLeft, treeLeft, mem} = check(left, mem)
    {costRight, treeRight, mem} = check(right, mem)
    {costLeft + costRight + l, {treeLeft, treeRight}, mem}
  end
  def cost([s], l, left, [], mem) do
    {cost, tree, mem} = check(left, mem)
    {cost + s + l, {s, tree}, mem}
  end
  def cost([s], l, [], right, mem) do
    {cost, tree, mem} = check(right, mem)
    {cost + s + l, {s, tree}, mem}
  end
  def cost([s | rest], l, left, right, mem) do
    {costLeft, treeLeft, mem} = cost(rest, s + l, [s | left], right, mem)
    {costRight, treeRight, mem} = cost(rest, s + l, left, [s | right], mem)
    if costLeft < costRight do
      {costLeft, treeLeft, mem}
    else
      {costRight, treeRight, mem}
    end
  end
end

defmodule SolutionThree do
  @moduledoc """

  """
  def cost([]) do {0, :na} end
  def cost(seq) do
    {cost, tree, _} = cost(Enum.sort(seq), Memo.treeNew())
    {cost, tree}
  end
  def cost([s], mem) do {0, s, mem} end
  def cost([s | rest] = seq, mem) do
    {c, t, mem} = cost(rest, s, [s], [], mem)
    {c, t, Memo.treeInsert(mem, seq, {c, t})}
  end
  def check(seq, mem) do
    case Memo.treeLookup(mem, seq) do
      nil ->
        cost(seq, mem)
      {c, t} ->
        {c, t, mem}
    end
  end
  def cost([], l, left, right, mem) do
    {costLeft, treeLeft, mem} = check(Enum.reverse(left), mem)
    {costRight, treeRight, mem} = check(Enum.reverse(right), mem)
    {costLeft + costRight + l, {treeLeft, treeRight}, mem}
  end
  def cost([s], l, left, [], mem) do
    {cost, tree, mem} = check(Enum.reverse(left), mem)
    {cost + s + l, {s, tree}, mem}
  end
  def cost([s], l, [], right, mem) do
    {cost, tree, mem} = check(Enum.reverse(right), mem)
    {cost + s + l, {s, tree}, mem}
  end
  def cost([s | rest], l, left, right, mem) do
    {costLeft, treeLeft, mem} = cost(rest, s + l, [s | left], right, mem)
    {costRight, treeRight, mem} = cost(rest, s + l, left, [s | right], mem)
    if costLeft < costRight do
      {costLeft, treeLeft, mem}
    else
      {costRight, treeRight, mem}
    end
  end
end
