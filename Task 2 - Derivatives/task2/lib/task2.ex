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
    d1 = deriv(e, :x)
    c = calc(d1, :x, 5)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d1)}\n")
    IO.write("Simplified: #{pprint(simplify(d1))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
  end

  def test2() do
    e = {:add,
          {:exp, {:var, :x}, {:num, 3}},
          {:num, 4}
        }
    d1 = deriv(e, :x)
    c = calc(d1, :x, 5)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d1)}\n")
    IO.write("Simplified: #{pprint(simplify(d1))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
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
  def deriv({:exp, e, {:num, n}}, v) do
    {:mul,
      {:mul, {:num, n}, {:exp, e, {:num, n-1}}},
      deriv(e, v)
    }
  end


  def calc({:num, n}, _, _) do {:num, n} end
  def calc({:var, v}, v, n) do {:num, n} end
  def calc({:var, v}, _, _) do {:num, v} end
  def calc({:add, e1, e2}, v, n) do
    {:add, calc(e1, v, n), calc(e2, v, n)}
  end
  def calc({:mul, e1, e2}, v, n) do
    {:mul, calc(e1, v, n), calc(e2, v, n)}
  end
  def calc({:exp, e1, e2}, v, n) do
    {:exp, calc(e1, v, n), calc(e2, v, n)}
  end


  def simplify({:add, e1, e2}) do
    simplify_add(simplify(e1), simplify(e2))
  end
  def simplify({:mul, e1, e2}) do
    simplify_mul(simplify(e1), simplify(e2))
  end
  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1), e2)
  end
  def simplify(e) do e end

  def simplify_add({:num, 0}, e2) do e2 end
  def simplify_add(e1, {:num, 0}) do e1 end
  def simplify_add{:num, n1}, {:num, n2} do {:num, n1 + n2} end
  def simplify_add(e1, e2) do {:add, e1, e2} end

  def simplify_mul({:num, 1}, e2) do e2 end
  def simplify_mul(e1, {:num, 1}) do e1 end
  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1 * n2} end
  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul(_,{:num, 0}) do {:num, 0} end
  def simplify_mul(e1, e2) do {:mul, e1, e2} end

  def simplify_exp(e1, {:num, 1}) do e1 end
  def simplify_exp(_, {:num, 0}) do {:num, 1} end
  def simplify_exp({:num, n}, {:num, m}) do {:num, n ** m} end
  def simplify_exp(e1, e2) do {:exp, e1, e2} end


  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
  def pprint({:mul, e1, e2}) do "#{pprint(e1)} * #{pprint(e2)}" end
  def pprint({:exp, e1, e2}) do "(#{pprint(e1)}) ^ (#{pprint(e2)})" end
end
