defmodule Shunt do
  @doc """
  Finding moves to rearange wagons in xs to get ys.
  """
  def find(_, []) do [] end
  def find([], _) do [] end
  def find(xs, [y | ys]) do
    {hs, ts} = Processing.split(xs, y)

    moves = [
      {:one, 1 + Enum.count(ts)},
      {:two, Enum.count(hs)},
      {:one, -(1 + Enum.count(ts))},
      {:two, -(Enum.count(hs))}
    ]

    moves ++ find(ts ++ hs, ys)
  end

  @doc """
  Finds moves but removes if the lower track becomes 0.
  """
  def few(_, []) do [] end
  def few([], _) do [] end
  def few(xs, [y | ys]) do
    {hs, ts} = Processing.split(xs, y)

    moves = [
      {:one, 1 + Enum.count(ts)},
      {:two, Enum.count(hs)},
      {:one, -(1 + Enum.count(ts))},
      {:two, -(Enum.count(hs))}
    ]

    if Enum.count(hs) == 0 do
      [] ++ few(ts, ys)
    else
      moves ++ few(ts ++ hs, ys)
    end
  end

  @doc """
  Compresses moves using four different rules.
  """
  def compress(ms) do
    ns = rules(ms)
    IO.inspect({ns, ms})
    cond do
      ns == ms ->
        ms
      true ->
        compress(ns)
    end
  end

  @doc """
  1. Replace {:one,n} directly followed by {:one,m} with {:one,n+m}.
  2. Replace {:two,n} directly followed by {:two,m} with {:two,n+m}.
  3. Remove {:one,0}.
  4. Remove {:two,0}.
  """
  def rules([]) do [] end
  def rules([{track, step} | moves]) do
    cond do
      step == 0 ->
        rules(moves)
      moves != [] ->
        [{nextTrack, nextStep} | nextMoves] = moves
        cond do
          track == :one && nextTrack == :one ->
            [{:one, step + nextStep}] ++ rules(nextMoves)
          track == :two && nextTrack == :two ->
            [{:two, step + nextStep}] ++ rules(nextMoves)
          true ->
            [{track, step}] ++ rules(moves)
        end
      true ->
        [{track, step}] ++ rules(moves)
    end
  end
end
