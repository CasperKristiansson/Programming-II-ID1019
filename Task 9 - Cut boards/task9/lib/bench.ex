defmodule Bench do
  def benchOne(n) do
    for i <- 1..n do
      {t, _} = :timer.tc(fn() -> Lumber.cost(Enum.to_list(1..i)) end)
      IO.puts(" n = #{i}\t t = #{t} us")
    end
  end

  def benchTwo(n) do
    for i <- 1..n do
      {t, _} = :timer.tc(fn() -> Lumber.costMemo(Enum.to_list(1..i)) end)
      IO.puts(" n = #{i}\t t = #{t} us")
    end
  end
end
