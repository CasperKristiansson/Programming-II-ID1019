defmodule SolutionThree do
  @moduledoc """
  The third solution is identical to the second solution with
  the difference that when we find a prime number, we first add
  it to the list of prime numbers. When we have no numbers left,
  we take and turn the list of prime numbers so that they come
  in numerical order.
  """

  def primes(n) do
    lst = Enum.to_list(2..n)
    res = []
    Enum.reverse(recursion(lst, res))
  end

  def recursion([head | tail], res) do
    if tail == [] do
      res
    else
      if Enum.any?(res, fn(x) -> rem(head, x) == 0 end) do
        recursion(tail, res)
      else
        recursion(tail, [head | res])
      end
    end
  end
end
