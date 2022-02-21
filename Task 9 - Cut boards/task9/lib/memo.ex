defmodule Memo do
  def new() do %{} end
  def add(mem, key, val) do Map.put(mem, key, val) end
  def lookup(mem, key) do Map.get(mem, key) end


  def addBinary(mem, key, val) do
    Map.put(mem, :binary.list_to_bin(key), val)
    end
  def lookupBinary(mem, key) do
    Map.get(mem, :binary.list_to_bin(key))
  end


  def test() do
    tree = treeInsert([], [2], {1, 2})
    tree = treeInsert(tree, [1, 2], {1, 3})
    tree = treeInsert(tree, [1, 3], {1, 4})
    tree = treeInsert(tree, [1, 2, 3], {1, 21})
    IO.inspect(tree)
    treeLookup(tree, [2])
  end

  def treeNew() do [] end

  @doc """
  """
  def treeInsert([], [current | []], value) do
    [{current, value, []}]
  end
  def treeInsert([], [current | next], value) do
    [{current, nil, treeInsert([], next, value)}]
  end
  def treeInsert([{treeN, _, _} | _] = tree, [current | []], value) do
    if treeN == current do
      tree
    else
      tree ++ [{current, value, []}]
    end
  end
  def treeInsert([{treeN, treeValue, branches} | rest], [current | next] = key, value) do
    if treeN == current do
      [{treeN, treeValue, treeInsert(branches, next, value)}] ++ rest
    else
      [{treeN, treeValue, branches} | treeInsert(rest, key, value)]
    end
  end


  def treeLookup([], _) do nil end
  def treeLookup([{treeN, treeValue, _} | rest], [current | []]) do
    if treeN == current do
      treeValue
    else
      treeLookup(rest, [current])
    end
  end
  def treeLookup([{treeN, _, branches} | rest], [current | next] = key) do
    if treeN == current do
      treeLookup(branches, next)
    else
      treeLookup(rest, key)
    end
  end
end
