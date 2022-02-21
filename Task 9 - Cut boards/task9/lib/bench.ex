defmodule Bench do
  def bench(n) do
    for i <- 1..n do
      {t, _} = :timer.tc(fn() -> Lumber.cost(Enum.to_list(1..i)) end)
      IO.puts(" n = #{i}\t t = #{t} us")
    end
  end
end
