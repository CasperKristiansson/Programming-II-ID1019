defmodule Task1 do
  def hello do
    "Hello World!"
  end

  def double(n) do
    n * 2
  end

  def product(m, n) do
    if m == 0 do
      0
    else
      n + product(m - 1, n)
    end
  end

  def product_case(m, n) do
    case m do
      0 -> 0
      _ -> n + product_case(m - 1, n)
    end
  end

  def nth(n, l) do
    Enum.at(l, n)
  end

  def len(l) do
    length(l)
  end

  def sum_list(list) do
    if length(list) == 0 do
      0
    else
      [head | tail] = list
      head + sum_list(tail)
    end
  end

  def remove(x, l) do
    Enum.filter(l, fn y -> y != x end)
  end

  def even_or_odd(number) do
    if rem(number, 2) == 0 do
      "Even"
    else
      "Odd"
    end
  end

  def opposite_number(number) do
    -number
  end

  def square_digits(list) do
    Enum.map(list, fn x -> x * x end)
  end

  @doc """
  55 -> 2525
  """
  def square_digit(n) do
    n
    |> Integer.digits()
    |> Enum.map(&to_string(&1 * &1))
    |> Enum.join()
    |> String.to_integer()
  end

  def count_vowels(string) do
    length(Enum.filter(String.graphemes(string), fn x -> x in ["a", "e", "i", "o", "u"] end))
  end

  def count_consonants(string) do
    length(Enum.filter(String.graphemes(string), fn x -> x not in ["a", "e", "i", "o", "u"] end))
  end

  @doc """
  1500,5,100,5000 ==> 15 years to reach 5000 in size
  """
  def population_growth(p0, percent, aug, p) do
    if p0 >= p do
      0
    else
      1 + population_growth(p0 + p0 * percent / 100 + aug, percent, aug, p)
    end
  end

  def insertion_sort(list) do
    insertion_sort(list, [])
  end

  def insertion_sort(list, sorted) do
    case length(list) do
      0 -> sorted
      _ -> (
        [head | tail] = list
        insertion_sort(tail, insert(head, sorted))
      )
    end
  end

  def insert(x, l) do
    if length(l) == 0 do
      [x]
    else
      [head | tail] = l
      if x <= head do
        [x, head | tail]
      else
        [head | insert(x, tail)]
      end
    end
  end
end
