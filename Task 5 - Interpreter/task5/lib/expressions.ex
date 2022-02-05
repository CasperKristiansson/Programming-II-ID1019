defmodule Eager do
  @moduledoc """

  """
  def eval_expr({:atm, id}, _) do {:ok, id} end
  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil ->
        :error
      {_, str} ->
        {:ok, str}
    end
  end
  def eval_expr({:cons, expression1, expression2}, env) do
    case eval_expr(expression1, env) do
      :error ->
        :error
      {:ok, s} ->
        case eval_expr(expression2, env) do
        :error ->
          :error
        {:ok, ts} ->
          {:ok, {s, ts}}
        end
    end
  end
end
