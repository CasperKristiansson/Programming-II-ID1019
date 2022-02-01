defmodule Test do
  def test() do
    Emulator.run(simple_test())
  end

  def simple_test() do
    {:prgm,
      [
        {:addi, 1, 1, 5},
        {:label, :loop},         # $1 <- 1 + 5 = 5
        {:add, 4, 2, 1},      # $4 <- $2 + $1
        {:addi, 5, 0, 1},     # $5 <- 0 + 1 = 1
        {:addi, 6, 0, 2},
        {:addi, 5, 5, 1},
        {:out, 5},
        {:out, 6},
        {:lw, 2, 2, :arg},
        {:sw, 2, 100, :arg},
        # {:beq, 5, 6, :loop},
        :halt
      ],
      [
        [{:label, :arg}, {:word, 20}]
      ]
    }
  end
end
