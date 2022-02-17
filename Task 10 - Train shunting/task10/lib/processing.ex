defmodule Processing do
  @moduledoc """
  Containts list processing routines for the train shunting.
  """

  @doc """
  Returns the list containing the first n elements of xs.
  """
  def take([], _) do [] end
  def take(_, 0) do [] end
  def take([head | tail], n) do
    [head] ++ take(tail, n - 1)
  end

  @doc """
  Returns the list xs without its first n elements.
  """
  def drop([], _) do [] end
  def drop(xs, 0) do xs end
  def drop([_ | tail], n) do
    drop(tail, n - 1)
  end

  @doc """
  Returns the list xs with the elements of ys appended.
  """
  def append(xs, ys) do xs ++ ys end

  @doc """
  Tests whether y is an element of xs.
  """
  def member(xs, y) do Enum.member?(xs, y) end

  @doc """
  Returns the first position of y in the list xs.
  """
  def position(xs, y) do
    Enum.find_index(xs, fn(x) -> x == y end) + 1
  end

  def split(xs, x) do
    {take(xs, position(xs, x) - 1), drop(xs, position(xs, x))}
  end
end
