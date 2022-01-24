# Derivatives

## Report

## Notes: Recursion

In *functional programming* a program is a set of functions where a function receives arguments and returns a result. **It does not change the given argument.**

### Error Handling In Elixir
If the function call bar fails, the program will handle the error and continue
with the function.-

```elixir
def foo(x, y) do
    res = try do
            bar(x, y)
        rescue
            error => 
                {:caught, error}
        end
    {x, y, res}
end
```

### List Pattern Matching
Different type of `list patterns` and how to match them.

```elixir	
[h|t] = [:a, [:b,:c]]
[h1,h2|t] = [:a,:b,:c]
[h1,h2,t] = [:a,:b,:c]
[h1|[h2|t]] = [:a,:b,:c]
[h|t] = [:a|:b]
```

### Appending to a list
Define a function `append` that appends an element to a list using recursion. The time complexity of this function is **O(n)**.

```elixir
def append([], x) do
    x
end
def append([h|t], x) do
    [h, append(t, x)]
end
```

| **List Length** | **Run-time** |
| :--- | :--- |
| `4000` | `50` |
| `8000` | `78` |
| `10000` | `85` |
| `12000` | `99` |
| `14000` | `102` |

### Union of Multisets
A *multiset* or bag is a set possibly with duplicated elements. The function below returns the `union` of two multisets using recursion.
```elixir
def union([], y) do y end
def union([h|t], y) do
    z = union(t,y)
    [h, z]
end
```
