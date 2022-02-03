defmodule SolutionTwo do
  @moduledoc """
  As in the first solution, you must create a list of all
  integers between 2 and the given number n. Also create a
  list of all prime numbers that you have found, which of course
  is initially an empty list. Pick the numbers from the list of all
  numbers, one by one, and check if it is divisible by any of
  the prime numbers you found. If it is divisible by a prime
  number, we discard it, but if it is not divisible by any prime
  number, we have found a new prime number that you add last in the
  list of prime numbers. When you have no numbers left, you have
  found all prime numbers.
  """

  def primes(n) do
    lst = Enum.to_list(2..n)
    res = []
    recursion(lst, res)
  end

  def recursion([head | tail], res) do
    if tail == [] do
      res
    else
      if Enum.any?(res, fn(x) -> rem(head, x) == 0 end) do
        recursion(tail, res)
      else
        recursion(tail, res ++ [head])
      end
    end
  end
end
