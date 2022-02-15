defmodule Primes do
  @moduledoc """
  """
  defstruct [:next]

  def primes() do
    %Primes{next: fn() -> {2, fn() -> sieve(z(3), 2) end} end}
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

  def next(primes) do
    {prime, funcNext} = primes.next.()
    {prime, %Primes{next: funcNext}}
  end

  def z(n) do
    fn() -> {n, z(n + 1)} end
  end

  def filter(func, f) do
    {numb, funcNext} = func.()
    if rem(numb, f) == 0 do
      filter(funcNext, f)
    else
      {numb, fn() -> filter(funcNext, f) end}
    end
  end

  def primef() do
    fn() -> {2, fn() -> sieve(z(3), 2) end} end
  end

  def sieve(n, p) do
    {numb, funcNext} = filter(n, p)
    {numb, fn() -> sieve(funcNext, numb) end}
  end
end
