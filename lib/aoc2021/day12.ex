defmodule CaveNode do
  defstruct children: []

  def add_conn(node, to) do
    if Enum.member?(node.children, to) do
      node
    else
      %CaveNode{children: [
        to | node.children
      ]}
    end
  end
end

defmodule CaveMap do
  defstruct nodes: %{}

  @doc """
  Get a node in the tree.
  """
  def get_node(tree, key) do
    tree.nodes
      |> Map.get(key, %CaveNode{})
  end

  @doc """
  Set a node in a tree.
  """
  def set_node(tree, key, node) do
    nodes = tree.nodes
      |> Map.put(key, node)
    %CaveMap{
      nodes: nodes
    }
  end

  @doc """
  Add a new node connection.
  """
  def add_conn(tree, from, to) do
    node1 = get_node(tree, from) |> CaveNode.add_conn(to)
    node2 = get_node(tree, to)   |> CaveNode.add_conn(from)

    tree
      |> set_node(from, node1)
      |> set_node(to,   node2)
  end
end

defmodule Aoc2021.Day12 do

  def build(paths, map \\ %CaveMap{})
  def build([h|t], map) do
    [from, to] = parse(h)
    build(t, CaveMap.add_conn(map, from, to))
  end
  def build(_, map), do: map

  defp parse(str) do
    str
      |> String.split("-", trim: true)
      |> Enum.map(&String.to_atom/1)
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp should_go1?(path, visited) do
    upcase? = & &1 == String.upcase(&1)
    string  = Atom.to_string(path)

    case upcase?.(string) do
      false -> Enum.member?(visited, path) == false
          _ -> true
    end
  end

  def search(map, nodeFn, visited \\ [:start])
  def search(map, nodeFn, visited) do
    [this | _] = visited

    cave = CaveMap.get_node(map, this)
    next = cave.children
      |> Enum.filter(fn path -> nodeFn.(path, visited) end)

    if this == :end do
      visited
        |> Enum.reverse()
        |> Enum.join(",")
    else
      next
        |> Enum.map(fn path -> search(map, nodeFn, [path | visited]) end)
        |> List.flatten()
    end
  end

  def part_one (input) do
    paths = input
      |> build()
      |> search(&(should_go1?/2))
    length(paths)
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  defp should_go2?(path, visited) do
    upcase? = & &1 == String.upcase(&1)
    string  = Atom.to_string(path)

    small_caves = visited
      |> Enum.map(&Atom.to_string/1)
      |> Enum.filter(&(upcase?.(&1) == false))

    has_small_twice =
      length(Enum.uniq(small_caves)) !==
      length(small_caves)

    cnt_small_limit = has_small_twice && 1 || 2

    cond do
      path == :start -> false

      upcase?.(string) == false -> Enum.count(visited, &(&1 == path)) < cnt_small_limit
      upcase?.(string) == true  -> true
    end
  end

  def part_two (input) do
    paths = input
      |> build()
      |> search(&(should_go2?/2))
    length(paths)
  end

end