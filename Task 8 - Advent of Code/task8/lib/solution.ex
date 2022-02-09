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

  def partTwo() do
    data = Data.readData()
    sum = getThreeValue(data, 0, 0)
    measureSlidingWindow(data, sum, 0)
  end

  def getThreeValue([], _, sum) do sum end
  def getThreeValue([head | tail], value, sum) do
    if value < 3 do
      getThreeValue(tail, value + 1, sum + head)
    else
      sum
    end
  end

  def measureSlidingWindow([], _, result) do result end
  def measureSlidingWindow([head | tail], value, result) do
    newValue = getThreeValue([head | tail], 0, 0)
    if newValue > value do
      measureSlidingWindow(tail, newValue, result + 1)
    else
      measureSlidingWindow(tail, newValue, result)
    end
  end
end
