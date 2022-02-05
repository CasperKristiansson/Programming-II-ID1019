defmodule Test do
  @moduledoc """
  """

  def test1() do
    env = Env.new()
    env = Env.add(:foo, 42, env)
    env = Env.add(:bar, "hello", env)
    env = Env.add(:baz, true, env)
    env = Env.add(:qux, false, env)
    env = Env.add(:quux, [1, 2, 3], env)

    lookup = Env.lookup(:foo, env)
    env2 = Env.remove([:foo, :bar], env)

    {env, env2, lookup}
  end

  @doc """
  eval expr({:atm, :a}, []) : returns {:ok, :a}
  eval expr({:var, :x}, [{:x, :a}]) : returns {:ok, :a}
  eval expr({:var, :x}, []) : returns :error
  eval expr({:cons, {:var, :x}, {:atm, :b}}, [{:x, :a}]) : returns {:ok, {:a, :b}}
  """
  def test2() do

    e1 = Eager.eval_expr({:atm, :a}, [])
    e2 = Eager.eval_expr({:var, :x}, [{:x, :a}])
    e3 = Eager.eval_expr({:var, :x}, [])
    e4 = Eager.eval_expr({:cons, {:var, :x}, {:atm, :b}}, [{:x, :a}])

    {e1, e2, e3, e4}
  end

  @doc """
  eval match({:atm, :a}, :a, []) : returns {:ok, []}
  eval match({:var, :x}, :a, []) : returns {:ok, [{:x, :a}]}
  eval match({:var, :x}, :a, [{:x, :a}]) : returns {:ok, [{:x, :a}]}
  eval match({:var, :x}, :a, [{:x, :b}]) : returns :fail
  eval match({:cons, {:var, :x}, {:var, :x}}, {:a, :b}, []) : returns :fail
  """
  def test3() do
    e1 = Eager.eval_match({:atm, :a}, :a, [])
    e2 = Eager.eval_match({:var, :x}, :a, [])
    e3 = Eager.eval_match({:var, :x}, :a, [{:x, :a}])
    e4 = Eager.eval_match({:var, :x}, :a, [{:x, :b}])
    e5 = Eager.eval_match({:cons, {:var, :x}, {:var, :x}}, {:a, :b}, [])

    {e1, e2, e3, e4, e5}
  end

  def test4() do
    seq = [{:match, {:var, :x}, {:atm, :a}},
          {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
          {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
          {:var, :z}
        ]

    Eager.eval(seq)
  end

  def test5() do
    seq = [{:match, {:var, :x}, {:atm, :a}},
            {:case, {:var, :x},
              [{:clause, {:atm, :b}, [{:atm, :ops}]},
                {:clause, {:atm, :a}, [{:atm, :yes}]}
              ]
            }
          ]

    Eager.eval_seq(seq, Env.new())
  end

  def test6() do
    seq = [{:match, {:var, :x}, {:atm, :a}},
            {:match, {:var, :f},
            {:lambda, [:y], [:x], [{:cons, {:var, :x}, {:var, :y}}]}},
            {:apply, {:var, :f}, [{:atm, :b}]}
          ]

    Eager.eval_seq(seq, Env.new())
  end
end
