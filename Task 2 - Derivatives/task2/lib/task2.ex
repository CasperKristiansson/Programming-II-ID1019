defmodule Derivative do
  @moduledoc """
  Documentation for `Derivative`.

  @type literal() :: {:num number()} | {:var, atom()}
  @type expr() :: literla() | {:add expr(), expr()} | {:mul, expr(), expr()}
  """

  def testSimple() do
    e = {:add,
          {:mul, {:num, 2}, {:var, :x}},
          {:num, 4}
        }
    d = deriv(e, :x)
    c = calc(d, :x, 5)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
  end

  def testExp() do
    e = {:add,
          {:exp, {:var, :x}, {:num, 3}},
          {:num, 4}
        }
    d = deriv(e, :x)
    c = calc(d, :x, 5)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
  end

  def testdiv() do
    e = {:div, {:num, 3}, {:var, :x}}
    d = deriv(e, :x)
    c = calc(d, :x, 2)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
  end

  def testln() do
    e = {:ln,
          {:mul,
            {:num, 2},
            {:var, :x}
          }
        }
    d = deriv(e, :x)
    c = calc(d, :x, 5)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
  end

  def testSqrt() do
    e = {:sqrt,
          {:mul,
            {:num, 5},
            {:var, :x}
          }
        }
    d = deriv(e, :x)
    c = calc(d, :x, 3)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
  end

  def testSin() do
    e = {:sin, {
          :mul,
          {:var, :x},
          {:num, 3}
          }
        }
    d = deriv(e, :x)
    c = calc(d, :x, 5)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
  end

  def testCos() do
    e = {:cos, {
          :mul,
          {:var, :x},
          {:num, 3}
          }
        }
    d = deriv(e, :x)
    c = calc(d, :x, 5)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
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
  def deriv({:div, {:num, n}, e}, v) do
    {:div,
      {:mul,
        {:num, -n},
        deriv(e, v)
      },
      {:exp, e, {:num, 2}}
    }
  end
  def deriv({:ln, e}, v) do
    {:div,
      deriv(e, v),
      e
    }
  end
  def deriv({:sqrt, e}, v) do
    {:div,
      deriv(e, v),
      {:mul, {:num, 2}, {:sqrt, e}}
    }
  end
  def deriv({:sin, e}, v) do
    {:mul,
      deriv(e, v),
      {:cos, e}
    }
  end
  def deriv({:cos, e}, v) do
    {:mul,
      {:num, -1},
      {:mul,
        deriv(e, v),
        {:sin, e}
      }
    }
  end

  def calc({:num, n}, _, _) do {:num, n} end
  def calc({:var, v}, v, n) do {:num, n} end
  def calc({:var, v}, _, _) do {:num, v} end
  def calc({:add, e1, e2}, v, n) do {:add, calc(e1, v, n), calc(e2, v, n)} end
  def calc({:mul, e1, e2}, v, n) do {:mul, calc(e1, v, n), calc(e2, v, n)} end
  def calc({:exp, e1, e2}, v, n) do {:exp, calc(e1, v, n), calc(e2, v, n)} end
  def calc({:ln, e}, v, n) do {:ln, calc(e, v, n)} end
  def calc({:div, e1, e2}, v, n) do {:div, calc(e1, v, n), calc(e2, v, n)} end
  def calc({:sqrt, e}, v, n) do {:sqrt, calc(e, v, n)} end
  def calc({:sin, e}, v, n) do {:sin, calc(e, v, n)} end
  def calc({:cos, e}, v, n) do {:cos, calc(e, v, n)} end


  def simplify({:add, e1, e2}) do
    simplify_add(simplify(e1), simplify(e2))
  end
  def simplify({:mul, e1, e2}) do
    simplify_mul(simplify(e1), simplify(e2))
  end
  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1), e2)
  end
  def simplify({:ln, e}) do
    simplify_ln(simplify(e))
  end
  def simplify({:div, e1, e2}) do
    simplify_div(simplify(e1), simplify(e2))
  end
  def simplify({:sqrt, e}) do
    simplify_sqrt(simplify(e))
  end
  def simplify({:sin, e}) do
    simplify_sin(simplify(e))
  end
  def simplify({:cos, e}) do
    simplify_cos(simplify(e))
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

  def simplify_ln({:num, 1}) do {:num, 0} end
  def simplify_ln({:num, 0}) do {:num, 0} end
  def simplify_ln(e) do {:ln, e} end

  def simplify_div({:num, n1}, {:num, n2}) do {:num, n1 / n2} end
  def simplify_div({:num, 1}, e2) do {:div, {:num, 1}, e2} end
  def simplify_div(e1, {:num, 1}) do e1 end
  def simplify_div(e1, e2) do {:div, e1, e2} end

  def simplify_sqrt({:num, n}) do {:num, n ** 0.5} end
  def simplify_sqrt(e) do {:sqrt, e} end

  def simplify_sin(e) do {:sin, e} end
  def simplify_cos(e) do {:cos, e} end


  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
  def pprint({:mul, e1, e2}) do "(#{pprint(e1)} * #{pprint(e2)})" end
  def pprint({:exp, e1, e2}) do "(#{pprint(e1)}) ^ (#{pprint(e2)})" end
  def pprint({:ln, e}) do "ln(#{pprint(e)})" end
  def pprint({:div, e1, e2}) do "(#{pprint(e1)} / #{pprint(e2)})" end
  def pprint({:sqrt, e}) do "sqrt(#{pprint(e)})" end
  def pprint({:sin, e}) do "sin(#{pprint(e)})" end
  def pprint({:cos, e}) do "cos(#{pprint(e)})" end
end
