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
  def eval_expr({:cons, exp1, exp2}, env) do
    case eval_expr(exp1, env) do
      :error ->
        :error
      {:ok, hs} ->
        case eval_expr(exp2, env) do
        :error ->
          :error
        {:ok, ts} ->
          {:ok, {hs, ts}}
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
  def eval_match({:cons, hp, tp}, {head, tail}, env) do
    case eval_match(hp, head, env) do
      :fail ->
        :fail
      {:ok, env} ->
        eval_match(tp, tail, env)
    end
  end
  def eval_match(_, _, _) do :fail end

  def eval_scope(exp, env) do Env.remove(extract_vars(exp, []), env) end

  def eval_seq([exp], env) do eval_expr(exp, env) end
  def eval_seq([{:match, exp1, exp2} | tail], env) do
    case eval_expr(exp2, env) do
      :error ->
        :error
      {:ok, str} ->
        env = eval_scope(exp1, env)
        case eval_match(exp1, str, env) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(tail, env)
        end
    end
  end

  def extract_vars({:atm, _}, v) do v end
  def extract_vars({:var, id}, v) do [id | v] end
  def extract_vars({:cons, exp1, exp2}, v) do
    extract_vars(exp1, extract_vars(exp2, v))
  end
  def extract_vars(:ignore, v) do v end

  def eval(exp) do
    case eval_seq(exp, Env.new()) do
      :error ->
        :error
      {:ok, str} ->
        str
    end
  end
end
