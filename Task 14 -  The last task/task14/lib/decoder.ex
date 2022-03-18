defmodule Decoder do
  def decode() do
    # morse = String.split(".- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ...")
    morse = String.split(".... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .----")
    tree = Morse.morse()
    decode(morse, tree)
  end
  def decode([], _) do [] end
  def decode([head | tail], tree) do
    [decode_char(head, tree) | decode(tail, tree)]
  end

  def decode_char(sequence, {:node, character, tree_left, tree_right}) do
    case String.at(sequence, 0) do
      "-" ->
        decode_char(String.slice(sequence, 1..-1), tree_left)
      "." ->
        decode_char(String.slice(sequence, 1..-1), tree_right)
      _ ->
        character
    end
  end
end
