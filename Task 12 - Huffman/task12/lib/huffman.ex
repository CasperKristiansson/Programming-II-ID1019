defmodule Huffman do
  @moduledoc """
  Algorithm: https://www.youtube.com/watch?v=dM6us854Jk0
  ASCII table: https://www.techonthenet.com/ascii/chart.php
  """
  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text() do
    'this is something that we should encode'
  end

  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    IO.inspect(encode)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end


  def tree(sample) do
    freq = freq(sample)
    freq = Enum.sort(freq, fn({_, x}, {_, y}) -> x < y end)
    huffman(freq)
  end

  @doc """
  Uses a map to count the frequency of each character in a text.
  """
  def freq(sample) do freq(sample, %{}) end
  def freq([], freq) do freq end
  def freq([char | rest], freq) do
    case Map.get(freq, char) do
      nil ->
        freq(rest, Map.put(freq, char, 1))
      value ->
        freq(rest, Map.put(freq, char, value + 1))
    end
  end

  @doc """
  {{{{110, 97}, {111, {98, {100, 13}}}}, 32},
  {{{108, {{10, {120, 113}}, 119}}, {{104, {{103, {122, 118}}, 121}}, 116}},
  {{{117, 114}, {{99, {{107, 106}, 109}}, 105}}, {101, {{112, 102}, 115}}}}}
  """
  def huffman([{tree, _}]) do tree end
  def huffman([{key, value}, {key2, value2} | rest]) do
    huffman(insert({key, value}, {key2, value2}, rest))
  end

  @doc """
  This method does not build on the orginal huffman algorithm. The original
  algorithm stores the frequency of each character and the character in the leafs
  while this solution ONLY stores the characters in the following structure:
  [{char1, char2}, freq1 + freq2]
  """
  def insert({key1, value1}, {key2, value2}, []) do
    [{{key1, key2}, value1 + value2}]
  end
  def insert({key1, value1}, {key2, value2}, [{key3, value3} | rest]) do
    if value1 + value2 < value3 do
      [{{key1, key2}, value1 + value2}] ++ [{key3, value3} | rest]
    else
      [{key3, value3}] ++ insert({key1, value1}, {key2, value2}, rest)
    end
  end


  def encode_table(tree) do
    find_path(tree, [])
  end

  def find_path({tree_left, tree_right}, current_path) do
    paths_left = find_path(tree_left, current_path ++ [0])
    paths_right = find_path(tree_right, current_path ++ [1])

    paths_left ++ paths_right
  end
  def find_path(tree, current_path) do
    [{tree, current_path}]
  end

  @doc """
  Because of the structure of find_path the encode_table could
  be used here as well.
  """
  def decode_table(tree) do
    encode_table(tree)
  end


  def encode(text, table) do
    get_bits(text, table)
  end

  def get_bits([], _) do [] end
  def get_bits([char | rest], tree) do
    get_path(char, tree) ++ get_bits(rest, tree)
  end

  def get_path(char, [{tree_char, path} | rest]) do
    if char == tree_char do
      path
    else
      get_path(char, rest)
    end
  end


  def decode([], _) do [] end
  def decode(seq, tree) do
    {char, rest} = decode_char(seq, 1, tree)
    [char | decode(rest, tree)]
  end

  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {char, _} ->
        {char, rest};
      nil ->
        decode_char(seq, n + 1, table)
    end
  end


  def read(file) do
    {:ok, file} = File.open(file, [:read, :utf8])
    binary = IO.read(file, :all)
    File.close(file)
    length = byte_size(binary)
    case :unicode.characters_to_list(binary, :utf8) do
    {:incomplete, list, rest} ->
      {list, length - byte_size(rest)}
    list ->
      {list, length}
    end
  end

  @doc """
  The bench method starts of by reading a file and creating a huffman tree for it.
  The function will than encode the exact same text and decode it again.
  """
  def bench() do
    {text, length} = read("data.txt")
    {tree, tree_time} = time(fn -> tree(text) end)
    {encode_table, encode_table_time} = time(fn -> encode_table(tree) end)
    {decode_table, decode_table_time} = time(fn -> decode_table(tree) end)
    {encode, encode_time} = time(fn -> encode(text, encode_table) end)
    {_, decoded_time} = time(fn -> decode(encode, decode_table) end)

    e = div(length(encode), 8)
    r = Float.round(e / length, 3)

    IO.puts("Tree Build Time: #{tree_time} us")
    IO.puts("Encode Table Time: #{encode_table_time} us")
    IO.puts("Decode Table Time: #{decode_table_time} us")
    IO.puts("Encode Time: #{encode_time} us")
    IO.puts("Decode Time: #{decoded_time} us")
    IO.puts("Compression Ratio: #{r}")
  end

  def time(func) do
    {func.(), elem(:timer.tc(fn () -> func.() end), 0)}
  end
end
