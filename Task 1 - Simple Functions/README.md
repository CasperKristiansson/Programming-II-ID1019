# Introduction - functional Programming

## Using Elixir directly in shell
Enter Elixir's interactive shell:
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