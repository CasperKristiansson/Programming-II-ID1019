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

  def eval_match(:ignore, _, env) do {:ok, env} end
  def eval_match({:atm, id}, id, env) do {:ok, env} end
  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      :nil ->
        {:ok, Env.add(id, str, env)}
      {_, ^str} ->
        {:ok, env}
      {_, _} ->
        :fail
    end
  end
  def eval_match({:cons, hp, tp}, [head | tail], env) do
    case eval_match(hp, head, env) do
      :fail ->
        :fail
      {:ok, env2} ->
        eval_match(tp, tail, env2)
    end
  end
  def eval_match(_, _, _) do :fail end

end
