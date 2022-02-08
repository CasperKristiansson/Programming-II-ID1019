defmodule Test do
  @moduledoc """
  This is a test module for the three different subtasks.
  """
  def test1 do
    SolutionOne.primes(101)
  end

  def test2 do
    SolutionTwo.primes(101)
  end

  def test3 do
    SolutionThree.primes(101)
  end

  def bench() do
    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024,16*1024]

    time = fn (i, f) ->
      elem(:timer.tc(fn () -> f.(i) end),0)
    end

    bench = fn (i) ->
      solutionOne = fn(numbs) ->
        SolutionOne.primes(numbs)
      end

      solutionTwo = fn(numbs) ->
        SolutionTwo.primes(numbs)
      end

      solutionThree = fn(numbs) ->
        SolutionThree.primes(numbs)
      end

      timeOne = time.(i, solutionOne)
      timeTwo = time.(i, solutionTwo)
      timeThree = time.(i, solutionThree)

      IO.write("  #{timeOne}\t\t\t#{timeTwo}\t\t\t#{timeThree}\n")
    end

    IO.write("# benchmark of the three different prime numbers solvers \n")
    Enum.map(ls, bench)
    :ok
  end
end
