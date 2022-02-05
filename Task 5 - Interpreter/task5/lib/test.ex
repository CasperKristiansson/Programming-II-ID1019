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

  def test2() do
    e1 = Eager.eval_expr({:atm, :a}, [])
    e2 = Eager.eval_expr({:var, :x}, [{:x, :a}])
    e3 = Eager.eval_expr({:var, :x}, [])
    e4 = Eager.eval_expr({:cons, {:var, :x}, {:atm, :b}}, [{:x, :a}])

    {e1, e2, e3, e4}
  end
end
