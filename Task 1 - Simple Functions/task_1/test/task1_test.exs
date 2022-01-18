defmodule Task1Test do
  use ExUnit.Case
  doctest Task1

  test "greets the world" do
    assert Task1.hello() == :world
  end
end
