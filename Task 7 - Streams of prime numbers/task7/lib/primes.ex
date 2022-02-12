defmodule Primes do
  @moduledoc """
  """
  defstruct [:next]

  def prime() do
    fn() -> {2, fn() -> sieve(z(2), 2) end} end
  end
  def primes() do
    %Primes{next: prime()}
  end

  defimpl Enumerable do
    def count(_) do {:error, __MODULE__} end
    def member?(_, _) do {:error, __MODULE__} end
    def slice(_) do {:error, __MODULE__} end

    def reduce(_, {:halt, acc}, _fun) do
      {:halted, acc}
    end
    def reduce(primes, {:suspend, acc}, fun) do
      {:suspended, acc, fn(cmd) -> reduce(primes, cmd, fun) end}
    end
    def reduce(primes, {:cont, acc}, fun) do
      {p, next} = Primes.next(primes)
      reduce(next, fun.(p,acc), fun)
    end
  end

  def z(n) do
    fn() -> increaseZ(n + 1) end
  end

  def increaseZ(n) do
    {n, fn() -> increaseZ(n + 1) end}
  end


  def filter(func, f) do
    {numb, funcNext} = func.()
    if rem(numb - 1, f) == 0 || numb - 1 < f do
      filter(funcNext, f)
    else
      {numb - 1, fn() -> filter(funcNext, f) end}
    end
  end

  def sieve(n, p) do
    lst = Enum.to_list(2..p)
    primes = recursionFilter(lst)
    nextPrime(n, p, primes)
  end

  def recursionFilter([head | []]) do [head] end
  def recursionFilter([head | tail]) do
    [head | recursionFilter(Enum.filter(tail, fn(x) -> rem(x, head) != 0 end))]
  end

  def nextPrime(n, p, primes) do
    {numb, funcNext} = n.()

    if isPrime(primes, numb) do
      {numb, fn() -> nextPrime(funcNext, p, primes ++ [numb]) end}
    else
      nextPrime(funcNext, p, primes)
    end
  end

  def isPrime([], _) do true end
  def isPrime([head | tail], p) do
    if rem(p, head) == 0 do
      false
    else
      isPrime(tail, p)
    end
  end

  def primes() do
    fn() -> {2, fn() -> sieve(z(2), 2) end} end
  end

  # Now for you to implement the function next/1, it should return a tuple,
  # the next prime and a Primes struct that represents the continuation.
  def next(primes) do
    primes.()
  end
end
