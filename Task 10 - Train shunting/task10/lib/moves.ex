defmodule Moves do
  def single({:one, steps}, {main, one, two}) do
    cond do
      steps > 0 ->
        main = Enum.reverse(main)
        one = Enum.reverse(one)
        {
          Enum.reverse(Processing.drop(main, steps)),
          Enum.reverse(Processing.append(one, Processing.take(main, steps))),
          two
        }
      steps < 0 ->
        {
          Processing.append(main, Processing.take(one, -steps)),
          Processing.drop(one, -steps),
          two
        }
      true ->
        {main, one, two}
    end
  end
  def single({:two, steps}, {main, one, two}) do
    cond do
      steps > 0 ->
        main = Enum.reverse(main)
        two = Enum.reverse(two)
        {
          Enum.reverse(Processing.drop(main, steps)),
          one,
          Enum.reverse(Processing.append(two, Processing.take(main, steps)))
        }
      steps < 0 ->
        {
          Processing.append(main, Processing.take(two, -steps)),
          one,
          Processing.drop(two, -steps),
        }
      true ->
        {main, one, two}
    end
  end
end
