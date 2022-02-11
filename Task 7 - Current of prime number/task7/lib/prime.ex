defmodule Primes do
  @moduledoc """
  """

  def z(n) do
    func = fn() ->
      increaseZ(n + 1)
    end
    func
  end

  def increaseZ(n) do
    func = fn() ->
      increaseZ(n + 1)
    end
    {n, func}
  end


  def filter(func, f) do
    {numb, funcNext} = func.()
    if rem(numb - 1, f) == 0 || numb - 1 < f do
      filter(funcNext, f)
    else
      filterFunc = fn() ->
        filter(funcNext, f)
      end
      {numb - 1, filterFunc}
    end
  end

  def sieve(n, p) do

  end
end
