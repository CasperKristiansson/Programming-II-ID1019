# Introduction - functional Programming

## Using Elixir directly in shell
Enter Elixir's interactive shell (start a new session with `elixir`):
```bash
iex
```

Declare variables and functions in the interactive shell:
```elixir
x = 5
x
# => 5

foo = fn(x) -> x + 1 end
foo.(2)
# => 3
```

## Using Elixir in Programs
```elixir
defmodule Test do
  def to_celsius(fahren) do
    (fahren - 32) / 1.8
  end
end
```

Creating a new Elixir project:
```bash
mix new my_app
```

The file structure of a mix project:
```
├───my_app
│   ├───lib
│   │   └───my_app.ex
│   │───test
│   │   ├───my_app_test.exs
│   │   └───test_helper.exs
│   |───.formatter.exs
|   |───.gitignore
|   |───mix.exs
```
Running test files:
```bash
mix test
```

Running a specific test file:
```bash
mix test --only test/my_app_test.exs
```

Running a specific file:
```bash
mix run lib\task1.ex
```

Compile the project:
```bash
mix compile
```

Starting a new session in a project (in cmd):
```bash
iex -S mix
```

Recompile the project inside session:
```bash
iex(1)> recompile()
```

## Example functions
Calculating the product of two numbers using recursion:
```elixir
def product_case(m, n) do
    case m do
      0 -> 0
      _ -> n + product_case(m - 1, n)
    end
  end
```

Mapping a list and applying a function to each element:
```elixir
def square_digits(list) do
  Enum.map(list, fn x -> x * x end)
end
```

List comprehension in Elixir:
```elixir
[x, y, z] = [1, 2, 3] # => [1, 2, 3]
[head | tail] = [1, 2, 3] #=> [1, [2, 3]]
[_, {x, y} | _] = [{:a, 1}, {:b, 2}, {:c, 3}, {:d, 4}] # => {:b, 2}
```