defmodule Eager do
  @moduledoc """
  """

  def eval(exp) do
    case eval_seq(exp, Env.new()) do
      :error ->
        :error
      {:ok, str} ->
        str
    end
  end


  def eval_expr({:atm, id}, _) do {:ok, id} end
  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      :nil ->
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
  def eval_expr({:case, expr, cls}, env) do
    case eval_expr(expr, env) do
      :error ->
        :error
      {:ok, str} ->
        eval_cls(cls, str, env)
    end
  end
  def eval_expr({:lambda, par, free, seq}, env) do
    case Env.closure(free, env) do
      :error ->
        :error
      closure ->
        {:ok, {:closure, par, seq, closure}}
    end
  end
  def eval_expr({:apply, expr, args}, env) do
    case eval_expr(expr, env) do
      :error ->
        :error
      {:ok, {:closure, par, seq, closure}} ->
        case eval_args(args, env) do
          :error ->
            :error
          {:ok, strs} ->
            env = Env.args(par, strs, closure)
            eval_seq(seq, env)
        end
    end
  end
  def eval_expr({:fun, id}, _) do
    {par, seq} = apply(Prgm, id, [])
    {:ok, {:closure, par, seq, []}}
  end
  def eval_expr({:call, id, args}, env) do
		case apply(Prgm, id, []) do
			:nil ->
        :error
			{par, seq} ->
        case eval_args(args, env) do
          :error ->
            :error
          {:ok, strs} ->
            env = Env.args(par, strs, env)
            eval_seq(seq, env)
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
  def eval_seq([], env) do env end


  def extract_vars({:atm, _}, v) do v end
  def extract_vars({:var, id}, v) do [id | v] end
  def extract_vars({:cons, exp1, exp2}, v) do
    extract_vars(exp1, extract_vars(exp2, v))
  end
  def extract_vars(:ignore, v) do v end


  def eval_cls([], _, _) do :error end
  def eval_cls([{:clause, ptr, seq} | cls], str, env) do
    env = eval_scope(ptr, env)
    case eval_match(ptr, str, env) do
      :fail ->
        eval_cls(cls, str, env)
      {:ok, env} ->
        eval_seq(seq, env)
    end
  end

  def eval_args([], _) do [] end
  def eval_args([exp | tail], env) do
    case eval_expr(exp, env) do
      :error ->
        :error
      {:ok, str} ->
        {:ok, [str | eval_args(tail, env)]}
    end
  end
end
