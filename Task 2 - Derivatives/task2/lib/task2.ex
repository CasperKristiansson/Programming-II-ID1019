defmodule Derivative do
  @moduledoc """
  Documentation for `Derivative`.

  @type literal() :: {:num number()} | {:var, atom()}
  @type expr() :: literla() | {:add expr(), expr()} | {:mul, expr(), expr()}
  """

  def test() do
    e = {:add,
          {:mul, {:num, 2}, {:var, :x}},
          {:num, 4}
        }
    deriv(e, :x)
  end

  def deriv({:num, _}, _) do {:num, 0} end
  def deriv({:var, v}, v) do {:num, 1} end
  def deriv({:var, _}, _) do {:num, 0} end
  def deriv({:add, e1, e2}, v) do
    {:add, deriv(e1, v), deriv(e2, v)}
  end
  def deriv({:mul, e1, e2}, v) do
    {:add,
      {:mul, deriv(e1, v), e2},
      {:mul, e1, deriv(e2, v)}
    }
  end
end
