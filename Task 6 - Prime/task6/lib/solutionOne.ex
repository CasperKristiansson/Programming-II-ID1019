defmodule SolutionOne do
  @moduledoc """
  Create a list of all integers between 2 and the given number n.
  You can use the call Enum.to_list (2..n) to create the list of numbers.
  The first number in the list is a prime number and it should be the first
  number in the list that we generate. Now remove all numbers in the rest of
  the list that are divisible by the first number, use the function rem / 2.
  If the result is an empty list, we are ready, otherwise you have found the
  next prime number.
  """

  def primes(n) do
    lst = Enum.to_list(2..n)
    recursionFilter(lst)
  end

  def recursionFilter([head | tail]) do
    if tail == [] do
      [head]
    else
      [head | recursionFilter(Enum.filter(tail, fn(x) -> rem(x, head) != 0 end))]
    end
  end
end
