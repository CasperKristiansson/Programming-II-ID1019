defmodule Test do
  def test() do
    Emulator.run(simple_test())
  end

  def simple_test() do
    {:prgm,
      [
        {:addi, 1, 1, 5},
        {:add, 4, 2, 1},
        {:lw, 2, 2, 1},
        {:sw, 2, 1, 5},
        {:addi, 5, 0, 1},
        {:addi, 6, 0, 2},
        {:label, :loop},
        {:addi, 5, 5, 1},
        {:out, 5},
        {:out, 6},
        {:beq, 5, 6, :loop},
        :halt
      ],
      Tree.tree_new()
    }
  end

  def testTree() do
    lst = Tree.tree_new()
    lst = Tree.tree_insert(5, 1, lst)
    lst = Tree.tree_insert(2, 1, lst)
    lst = Tree.tree_insert(3, 1, lst)
    lst = Tree.tree_insert(4, 1, lst)
    lst = Tree.tree_insert(1, 3, lst)
    lst = Tree.tree_insert(6, "loop", lst)
    lst = Tree.tree_insert(7, 1, lst)
    lst = Tree.tree_insert(3, 1, lst)
    lst = Tree.tree_insert(8, 1, lst)
    lst = Tree.tree_insert(9, 1, lst)

    Tree.tree_traverse("loop", lst)
  end
end
