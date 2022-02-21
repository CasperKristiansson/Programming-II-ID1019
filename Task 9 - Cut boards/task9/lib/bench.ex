defmodule Bench do
  @moduledoc """
  After change of tree structure
  n = 1   t = 1433 us
  n = 2   t = 0 us
  n = 3   t = 0 us
  n = 4   t = 0 us
  n = 5   t = 0 us
  n = 6   t = 102 us
  n = 7   t = 409 us
  n = 8   t = 921 us
  n = 9   t = 2560 us
  n = 10  t = 8294 us
  n = 11  t = 23961 us
  n = 12  t = 72806 us
  n = 13  t = 242483 us
  n = 14  t = 861798 us
  n = 15  t = 2732851 us

  n = 1   t = 0 us
  n = 2   t = 0 us
  n = 3   t = 0 us
  n = 4   t = 0 us
  n = 5   t = 307 us
  n = 6   t = 0 us
  n = 7   t = 204 us
  n = 8   t = 512 us
  n = 9   t = 2048 us
  n = 10  t = 6451 us
  n = 11  t = 20684 us
  n = 12  t = 65740 us
  n = 13  t = 218624 us
  n = 14  t = 695296 us
  n = 15  t = 2171904 us
  """
  def benchOne(n) do
    for i <- 1..n do
      {t, _} = :timer.tc(fn() -> SolutionOne.cost(Enum.to_list(1..i)) end)
      IO.puts(" n = #{i}\t t = #{t} us")
    end
  end

  def benchTwo(n) do
    for i <- 1..n do
      {t, _} = :timer.tc(fn() -> SolutionTwo.cost(Enum.to_list(1..i)) end)
      IO.puts(" n = #{i}\t t = #{t} us")
    end
  end

  def benchThree(n) do
    for i <- 1..n do
      {t, _} = :timer.tc(fn() -> SolutionThree.cost(Enum.to_list(1..i)) end)
      IO.puts(" n = #{i}\t t = #{t} us")
    end
  end
end
