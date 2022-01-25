# Recursion and Tree structure - Derivatives
* [Report: Task 2 - Derivatives](#Report)
* [Notes: Recursion](#Recursion)
* [Notes: Trees](#Trees)
* [Notes: Derivatives](#Derivatives)

<div id="Report"></div>

## Report: Task 2 - Derivatives
### Introduction
The second exercise of the course Programming II consisted of creating a
program which can derivative several types of functions. The author will be
discussing how the problem was solved, how the different types of operations
(addition, multiplication. . . ) was develop, how the result is simplified and
how the result is calculated.

### Method
The author firstly started off by watching the three different lectures on
recursion, trees, and derivatives. The recursion lecture covered the basics
of pattern matching and some simple elixir methods such as appending to
a list and union between two lists. The tree lecture included the basics of
tuples and a few of its distinct functions (insert, duplicate, delete). The last
lecture, derivatives, were a walkthrough of the exercise and how it could
be solved. It covered a couple off basic functions and how they could be
derivative, simplified and calculated. These three lectures gave sufficient
knowledge to solve the task.

The several types of mathematics expressions that the program should be
able to manage is addition, multiplication, exponential, natural log, division,
square root, sin, and cos. The program should also follow the different type
of derivation rules ($ \frac{d}{dx}(x)≡1 $, $ \frac{d}{dx}(c)≡0 $, $ \frac{d}{dx}(f) + g≡ \frac{d}{dx}(f) + \frac{d}{dx}(g) $, $ \frac{d}{dx}(f) * g≡ \frac{d}{dx}(f) * g + f*\frac{d}{dx}(g) $.) The author decided to solve the task using Abstract Syntax Trees (AST) to represent the different operations, variables, and numbers.

### Result
Figure 1 consists of the division test function. Each test function
creates an expression with the desired mathematics expression. Afterwards
the derivative is calculated using the deriv method and then its value for a specific x is calculated using calc. After all calculations have been made
the author writes to the console the start expression, the derivative of that
expression, the simplified expression, and the value for a specific x.

```Elixir
def testdiv() do
    e = {:div, {:num, 3}, {:var, :x}}
    d = deriv(e, :x)
    c = calc(d, :x, 2)
    IO.write("Expression: #{pprint(e)}\n")
    IO.write("Derivative: #{pprint(d)}\n")
    IO.write("Simplified: #{pprint(simplify(d))}\n")
    IO.write("Calculated: #{pprint(simplify(c))}\n")
end
```
*Figure 1: Test function for the method division*

#### **Derivation Functions**
The author will be discussing the several types of functions for most of the
operators. Some functions will not be mentioned if they are like others that
already have been stated. Because the most basic operations were shown in
the lecture, the author will not be discussing them.

The division derivation function starts of by calculating the multiplication between the negative top number and the derivation the bottom
number/expression. The next step is to calculate the exponential of the
denominator number with two. Combining those two calculations results in
the derivation of the start expression.

```Elixir
def deriv({:div, {:num, n}, e}, v) do
    {:div, {:mul, {:num, -n}, deriv(e, v)}, {:exp, e, {:num, 2}}}
end
```
*Figure 2: Division function*

The natural log function starts of by calculating the nominator which
is the derivative of the expression and the denominator is the expression.
```Elixir	
def deriv({:ln, e}, v) do
    {:div, deriv(e, v), e}
end
```
*Figure 3: Natural Log function*

The square root function starts of by calculating the derivative of the
expression for the nominator. The next step is to calculate multiplication
between two the original expression for the denominator. The square root
method is not able to compute advanced operations with square root, it can
manage $ \sqrt{x} $ and $ \sqrt{5x} $...
```Elixir	
def deriv({:sqrt, e}, v) do
    {:div, deriv(e, v), {:mul, {:num, 2}, {:sqrt, e}}}
end
```
*Figure 4: Square root function*

The sin function is calculated by multiplying the derivation of the variables inside the sin function and multiply them with original function.
```Elixir
def deriv({:sin, e}, v) do
    {:mul, deriv(e, v), {:cos, e}}
end
```
*Figure 5: Sin function*

#### **Simplifying expressions**
Depending on the expression, most of the time it could be easily simplified.
The expression could be simplified by creating different definition for what
the function should return in a specific case. For example, if the goal is to
multiply 1 with x, it could be simplified to just the variable x.

Figure 6 consists of four different cases. The first situation is the standard one where two different numbers divide each other, which can simply
be calculated. The next situation is when the nominator is divided by one,
which means that it equals the nominator. The last two situations cannot
be simplified further and therefore the result is just returned.

```Elixir
def simplify_div({:num, n1}, {:num, n2}) do {:num, n1 / n2} end
def simplify_div({:num, 1}, e2) do {:div, {:num, 1}, e2} end
def simplify_div(e1, {:num, 1}) do e1 end
def simplify_div(e1, e2) do {:div, e1, e2} end
```
*Figure 6: Simplify function for division*

#### **Calculating With Specific X Values**
The next step of the task is to calculate the value of a derived expression.
The calc function starts calculating a value from a specific X value by mapping out and filling in the different X values. Afterwards the result is entered
to the simplify method which will return a single digit which is the deviated
value for that X point. In figure 7 shows the different calc functions used to
calculate division.

```Elixir
def calc({:num, n}, _, _) do {:num, n} end
def calc({:var, v}, v, n) do {:num, n} end
def calc({:var, v}, _, _) do {:num, v} end
def calc({:div, e1, e2}, v, n) do {:div, calc(e1, v, n), calc(e2, v, n)} end
```
*Figure 7: Calculating a specific X value with the help of calc*

#### **Printing the equation**
To show the expression in a more readable way the author develops the
function pprint. The function is a recursive function which will continuously
print the different variables depending on the operation. Figure 8 consists
of the function for printing division.
```Elixir
def pprint({:div, e1, e2}) do "(#{pprint(e1)} / #{pprint(e2)})" end
```
*Figure 8: Calculating a specific X value with the help of calc*

#### **Combining**
After all of the functions have been develop and running the test from figure
1 produces the result which can be seen in figure 9.

```Elixir	
Expression: sqrt((5 * x)) #x = 3
Derivative: (((0 * x) + (5 * 1)) / (2 * sqrt((5 * x))))
Simplified: (5 / (2 * sqrt((5 * x))))
Calculated: 0.6454972243679028
```
*Figure 9: Sample Printout*

<br>
<br>
<br>
<br>

<div id="Recursion"></div>

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

<br>
<br>
<br>
<br>

<div id="Trees"></div>

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


<br>
<br>
<br>
<br>

<div id="Derivatives"></div>

## Notes: Derivatives
To represent derivatives it might be useful to convert it to a string.
Example
```text
3x^2 + 2x + π
"3x^2 + 2x + pi"
```
A **better** solution would be to use `Abstract Syntax Trees` (AST).

- Numbers: {:num, 124}, {:num, 12.4}...
- Variables: {:var, :x}, {:var, :y}...
- Constants: {:var, :pi}...

```elixir
@type literal() :: {:num, number()} | {:var, atom()}
```

- Operations: {:add, {:num, 1}, {:num, 2}}, {:sub, {:num, 1}, {:num, 2}}...
```elixir
@type expr() :: {:add, expr(), expr()} | {:mul, expr(), expr()} | literal()
```

For example:
```elixir
"2 * x + 3" -> {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 3}}
```

The derivative rules are:
- $ \frac{d}{dx}(x)≡1 $
- $ \frac{d}{dx}(c)≡0 $ *for any literal different from x*
- $ \frac{d}{dx}(f) + g≡ \frac{d}{dx}(f) + \frac{d}{dx}(g) $
- $ \frac{d}{dx}(f) * g≡ \frac{d}{dx}(f) * g + f*\frac{d}{dx}(g) $
