defmodule Tree do
  def tree_new() do :nil end
  def tree_insert(k, e, :nil) do {:leaf, k, e} end

  def tree_insert(k, e, {:node, key, value, left, right}) do
    cond do
      k == key -> {:node, k, e, left, right}
      k < key -> {:node, key, value, tree_insert(k, e, left), right}
      k > key -> {:node, key, value, left, tree_insert(k, e, right)}
    end
  end

  def tree_insert(k, e, {:leaf, key, value}) do
    cond do
      k == key -> {:leaf, k, e}
      k < key -> {:node, key, value, {:leaf, k, e}, :nil}
      k > key -> {:node, key, value, :nil, {:leaf, k, e}}
    end
  end

  def tree_lookup(k, {:node, key, value, left, right}) do
    cond do
      k == key -> value
      k < key -> tree_lookup(k, left)
      k > key -> tree_lookup(k, right)
    end
  end

  def tree_lookup(k, {:leaf, key, value}) do
    if k == key do
      value
    else 0
    end
  end

  def tree_lookup(_, :nil) do
    0
  end

  def tree_traverse(v, {:node, key, value, left, right}) do
    if v == value do
      key
    else
      tree_traverse(v, left) || tree_traverse(v, right)
    end
  end

  def tree_traverse(v, {:leaf, key, value}) do
    if v == value do
      key
    end
  end

  def tree_traverse(_, :nil) do
  end
end
