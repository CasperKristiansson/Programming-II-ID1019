defmodule Task1 do
  def hello do
    "Hello World!"
  end

  def even_or_odd(number) do
    if rem(number, 2) == 0 do
      "Even"
    else
      "Odd"
    end
  end

  def sum_list(list) do
    Enum.sum(list)
  end

  def opposite_number(number) do
    -number
  end

  def square_digits(list) do
    Enum.map(list, fn x -> x * x end)
  end

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
end
