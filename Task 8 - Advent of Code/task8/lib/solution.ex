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

  def getThreeValue([], _, _) do :nil end
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
    cond do
      newValue == :nil ->
        result
      newValue > value ->
        measureSlidingWindow(tail, newValue, result + 1)
      true ->
        measureSlidingWindow(tail, newValue, result)
    end
  end

  def partThree() do
    data = Data.readCoordinates()
    coordinates(data, 0, 0)
  end

  def coordinates({[], []}, x, y) do x * y end
  def coordinates({[direction | directions], [step | steps]}, x, y) do
    case direction do
      "forward" ->
        coordinates({directions, steps}, x + step, y)
      "down" ->
        coordinates({directions, steps}, x, y + step)
      "up" ->
        coordinates({directions, steps}, x, y - step)
    end
  end

  def partFour() do
    data = Data.readCoordinates()
    aiming(data, 0, 0, 0)
  end

  def aiming({[], []}, x, _, depth) do x * depth end
  def aiming({[direction | directions], [step | steps]}, x, y, depth) do
    case direction do
      "forward" ->
        aiming({directions, steps}, x + step, y, step * y + depth)
      "down" ->
        aiming({directions, steps}, x, y + step, depth)
      "up" ->
        aiming({directions, steps}, x, y - step, depth)
    end
  end
end
