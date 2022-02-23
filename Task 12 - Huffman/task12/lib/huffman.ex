defmodule Huffman do
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
    # decode = decode_table(tree)
    # text = text()
    # seq = encode(text, encode)
    # decode(seq, decode)
  end

  def tree(sample) do
    freq = freq(sample)
    freq = Enum.sort(freq, fn({_, x}, {_, y}) -> x < y end)
    huffman(freq)
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

  def decode_table(tree) do

  end

  def encode(text, table) do

  end

  def decode(seq, tree) do

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
end
