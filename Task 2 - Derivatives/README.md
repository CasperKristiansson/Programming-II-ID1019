# Derivatives

## Report

## Notes: Recursion
In *functional programming* a program is a set of functions where a function receives arguments and returns a result. **It does not change the given argument.** Documentation: https://elixir-lang.org/getting-started/recursion.html

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

| **List Length** | **Run-time (ms)** |
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

## Notes: Trees
### Compound Structures
- elem/2 - accesses a tuple by index
- put_elem/3 - inserts a value into a tuple by index
- tuple_size/1 - gets the number of elements in a tuple

`Tuples` are intended as fixed-size containers for multiple elements. To manipulate a collection of elements, use a list instead. Enum functions do not work on tuples. Different types of functions that are available on tuples are:
append(tuple, value)
Inserts an element at the end of a tuple.

- delete_at(tuple, index):
Removes an element from a tuple.
- duplicate(data, size): 
Creates a new tuple.
- insert_at(tuple, index, value):
Inserts an element into a tuple.
- product(tuple):
Computes a product of tuple elements.
- sum(tuple):
Computes a sum of tuple elements.
- to_list(tuple):
Converts a tuple to a list.

Documentation: https://hexdocs.pm/elixir/1.13/Tuple.html

```elixir	
tuples: {:student, “Sune Mangs”, :cinte, 2012, :sunem}
lists: [:sunem, :joed, :sueb, :anng]
```
```elixir
iex> tuple = {:foo, :bar}
iex> Tuple.append(tuple, :baz)
{:foo, :bar, :baz}
```

`Lists` are handled more efficiently by the compiler and run-time system.
Recursively return nth element of a list. This method **cannot** be implemented using tuples.

```elixir
def nth(1, [r|_]) do r end
def nth(n, [_|t]) do nth(n-1, t) end
```

```elixir
elem(tuple, n):
Enum.at(list, n):
```

### Queue in Elixir
The following code implements a `queue` in Elixir.

```elixir
def module Queue do
    def add({:queue, front, back}, elem) do
        {:queue, front, [elem|back]}
    end
    def remove({:queue, [elem|rest], back}) do
        {:ok, elem, {:queue, rest, back}}
    end
    def remove({:queue, [], back) do
        case reverse(back) do
            [] ->
                :fail
            [elem|rest] ->
                {:ok, elem, {:queue, rest, []}}
    end
end
```

### Binary Tree using Tuples
How to represent a `binary tree` in Elixir.
```elixir
tree = {:node, :b, {:leaf, :a}, {:leaf, :c}}
t = {:node, 38, {:leaf, 42}, {:leaf, 34}}
```

![Trees](/Images/Lecture%20Trees.png)


### Summary
- `Lists`: a stack structure, easy to push and pop, simple to work with
- `Tuples`: constant time random access, expensive to change when large
- `Queues`: implemented using lists, amortized time complexity O(1)
- `Trees`: O(lg(n)) operations