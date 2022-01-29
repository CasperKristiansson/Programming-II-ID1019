defmodule Bench do
  def bench() do

    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

    time = fn (i, f) ->
      seq = Enum.map(1..i, fn(_) -> :rand.uniform(100000) end)
      elem(:timer.tc(fn () -> f.(seq) end),0)
    end

    bench = fn (i) ->

      list = fn (seq) ->
        List.foldr(seq, list_new(), fn (e, acc) -> list_insert(e, acc) end)
      end

      tree = fn (seq) ->
        List.foldr(seq, tree_new(), fn (e, acc) -> tree_insert(e, acc) end)
      end

      tl = time.(i, list)
      tt = time.(i, tree)

      IO.write("  #{tl}\t\t\t#{tt}\n")
    end

    IO.write("# benchmark of lists and tree \n")
    Enum.map(ls, bench)

    :ok
  end

  def test() do
    lst = tree_new()
    lst = tree_insert(5, lst)
    lst = tree_insert(2, lst)
    lst = tree_insert(3, lst)
    lst = tree_insert(4, lst)
    lst = tree_insert(5, lst)
    lst = tree_insert(6, lst)
    lst = tree_insert(7, lst)
    lst = tree_insert(3, lst)
    lst = tree_insert(6, lst)
    lst = tree_insert(2, lst)
    lst
  end

  def list_new() do [] end

  def list_insert(e, []) do [e] end

  def list_insert(e, [h | t]) do
    if e < h do
      [e | [h | t]]
    else
      [h | list_insert(e, t)]
    end
  end

  def tree_new() do :nil end
  def tree_insert(e, :nil) do {:leaf, e} end

  def tree_insert(e, {:node, value, left, right}) do
    if e < value do
      {:node, value, tree_insert(e, left), right}
    else
      {:node, value, left, tree_insert(e, right)}
    end
  end

  def tree_insert(e, {:leaf, value}) do
    if e < value do
      {:node, value, {:leaf, e}, :nil}
    else
      {:node, value, :nil, {:leaf, e}}
    end
  end
end
