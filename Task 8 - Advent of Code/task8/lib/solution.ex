defmodule Solution do
  @moduledoc """
  Documentation for `Solution`.
  """

  def partOne() do
    data = Data.readData()
    [head | _] = data
    measurementsIncreasing(data, head, 0)
  end

  def measurementsIncreasing([], _, result) do result end
  def measurementsIncreasing([head | tail], previous, result) do
    if head > previous do
      measurementsIncreasing(tail, head, result + 1)
    else
      measurementsIncreasing(tail, head, result)
    end
  end
end
