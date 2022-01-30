defmodule Test do
  def test() do
    # Emulator.run(simple_test())
    {code, data} = Emulator.load(simple_test())
    {code, data}
  end

  def simple_test() do
    {:prgm,
      [
        {:addi, 1, 1, 5},     # $1 <- 1 + 5 = 6
        {:add, 4, 2, 1},      # $4 <- $2 + $1
        {:addi, 5, 0, 1},     # $5 <- 0 + 1 = 1
        :halt
      ],
      [
        {[]}
      ]
    }
  end
end
