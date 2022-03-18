defmodule Encoding do
  def generate_map({:node, :na, tree_left, tree_right}, map, current_path) do
    map = generate_map(tree_left, map, current_path <> "-")
    generate_map(tree_right, map, current_path <> ".")
  end
  def generate_map({:node, character, :nil, :nil}, map, current_path) do
    Map.put(map, [character], current_path)
  end
  def generate_map({:node, character, tree_left, :nil}, map, current_path) do
    map = generate_map(tree_left, map, current_path <> "-")
    Map.put(map, [character], current_path)
  end
  def generate_map({:node, character, :nil, tree_right}, map, current_path) do
    map = generate_map(tree_right, map, current_path <> ".")
    Map.put(map, [character], current_path)
  end
  def generate_map({:node, character, tree_left, tree_right}, map, current_path) do
    map = generate_map(tree_left, map, current_path <> "-")
    map = generate_map(tree_right, map, current_path <> ".")
    Map.put(map, [character], current_path)
  end
  def generate_map(_, map, _) do map end


  def encode(str) do
    morse_tree = Morse.morse()
    map = generate_map(morse_tree, %{}, "")
    encoder(map, str, "")
  end
  def encoder(_, [], result) do result end
  def encoder(map, [head | tail], result) do
    case Map.get(map, [head]) do
      nil ->
        encoder(map, tail, result)
      char ->
        encoder(map, tail, result <> " " <> char)
    end
  end
end
