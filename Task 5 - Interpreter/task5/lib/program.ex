defmodule Prgm do
  @moduledoc """
  """
  def append() do
    {[:x, :y],
      [{:case, {:var, :x},
        [{:clause, {:atm, []}, [{:var, :y}]},
          {:clause, {:cons, {:var, :hd}, {:var, :tl}},
            [{:cons,
              {:var, :hd},
              {:call, :append, [{:var, :tl}, {:var, :y}]}}]
        }]
      }]
    }
    # {{:a, {:b, :nil}}, {:c, {:d, :nil}}}
  end
end
