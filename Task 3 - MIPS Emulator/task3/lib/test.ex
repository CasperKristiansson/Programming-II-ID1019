defmodule Test do
  def test() do
    Emulator.run(simple_test())
  end

  def simple_test() do
    {:prgm,
      [
        {:addi, 1, 1, 5},     # $1 <- 1 + 5 = 5
        {:add, 4, 2, 1},      # $4 <- $2 + $1
        {:addi, 5, 0, 1},     # $5 <- 0 + 1 = 1
        {:lw, 2, 2, :arg},
        {:sw, 2, 100, :arg},
        :halt
      ],
      [
        [{:label, :arg}, {:word, 20}]
      ]
    }
  end
end
