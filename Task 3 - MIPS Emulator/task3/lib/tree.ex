defmodule Tree do
  def tree_new() do :nil end
  def tree_insert(k, e, :nil) do {:leaf, k, e} end

  def tree_insert(k, e, {:node, key, value, left, right}) do
    if k < key do
      {:node, key, value, tree_insert(k, e, left), right}
    else
      {:node, key, value, left, tree_insert(k, e, right)}
    end
  end

  def tree_insert(k, e, {:leaf, key, value}) do
    if k < key do
      {:node, key, value, {:leaf, k, e}, :nil}
    else
      {:node, key, value, :nil, {:leaf, k, e}}
    end
  end
end
