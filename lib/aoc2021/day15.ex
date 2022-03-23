defmodule Aoc2021.Day15 do

  alias Graph

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def inside?(map, {x, y}) do
    ylen = -1 + Enum.count(map)
    xlen = -1 + Enum.count(map |> List.first)
    cond do
      x < 0    -> false
      y < 0    -> false
      y > ylen -> false
      x > xlen -> false
          true -> true
    end
  end

  def get(map, x, y) do
    map
      |> Enum.at(y)
      |> Enum.at(x)
  end

  def build(input) do
    map = input
      |> String.split(~r/\R/, trim: true)
      |> Enum.map(&(String.split(&1, "", trim: true)))
    
    for y <- 0..(-1 + Enum.count(map)) do
    for x <- 0..(-1 + Enum.count(map |> Enum.at(y))) do
      w = get(map, x, y)
        |> String.to_integer
      {{x, y}, w}
    end
    end
  end
  
  def edges(map) do
    points = map
      |> List.flatten
      |> Enum.reduce([], fn {{x, y}, _}, acc ->
        edges =
          [{x-1, y}, {x+1, y}, {x, y-1}, {x, y+1}]
          |> Enum.filter(fn point -> inside?(map, point) end)
          |> Enum.map(fn {px, py} ->
            {
              {x, y},
              {px, py},
              weight: get(map, px, py)
                |> elem(1)
            }
          end)
        acc ++ edges
      end)
  end

  def part_one (input) do
    map = input |> build
    min = {0, 0}
    max = map
      |> List.last
      |> List.last
      |> elem(0)

    path = Graph.new
      |> Graph.add_edges(map |> edges())
      |> Graph.dijkstra(min, max)
      |> List.delete_at(0)

    Enum.reduce(path, 0, fn {x, y}, acc ->
      acc + (get(map, x, y) |> elem(1))
    end)
  end

end