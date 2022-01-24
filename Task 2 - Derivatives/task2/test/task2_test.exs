defmodule Task2Test do
  use ExUnit.Case
  doctest Task2

  test "greets the world" do
    assert Task2.hello() == :world
  end
end
