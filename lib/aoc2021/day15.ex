defmodule Aoc2021.Day15 do

  alias Graph

  def render(map, highlight \\ [])
  def render(map, highlight) do
    for y <- 0..(-1 + Enum.count(map)) do
    for x <- 0..(-1 + Enum.count(map |> Enum.at(y))) do
      if Enum.member?(highlight, {x, y}) do
        #IO.write elem(get(map, x, y), 1)
        IO.write '#'
      else
        #IO.write elem(get(map, x, y), 1)
        IO.write '.'
      end
    end
      IO.puts ""
    end
  end

  defp concat(list, [item | tail]) do
    concat([item | list], tail)
  end
  defp concat(list, []), do: list

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
    map
      |> List.flatten
      |> Enum.reduce([], fn {{x, y}, _}, acc ->
        nbs =
          [{x-1, y}, {x+1, y}, {x, y-1}, {x, y+1}]
          |> Enum.filter(&(inside?(map, &1)))
          |> Enum.map(fn {px, py} -> 
            {{x, y}, {px, py}, weight: get(map, px, py) |> elem(1), vertex_identifier: {x, y}}
          end)
       concat(acc, nbs)
      end)
  end

  def part_one (input) do
    map = input |> build
    min = {0, 0}
    max = map |> List.last |> List.last |> elem(0)

    path = Graph.new
      |> Graph.add_edges(map |> edges())
      |> Graph.dijkstra(min, max)
      |> List.delete_at(0)

    Enum.reduce(path, 0, fn {x, y}, acc ->
      acc + (get(map, x, y) |> elem(1))
    end)
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def scale(map, xlen, ylen) do
    h = map |> Enum.count
    w = map |> List.first |> Enum.count

    for y <- 0..(ylen * h - 1) do
    for x <- 0..(xlen * w - 1) do
      lx = rem(x, h)
      ly = rem(y, w)
      lw = get(map, lx, ly)
        |> elem(1)

      wm = floor(x/w) + floor(y/h)
      tw = wm + lw
        |> Kernel.-(1) |> rem(9)
        |> Kernel.+(1)

      {{x, y}, tw}
    end
    end
  end

  def part_two (input) do
    map = input
      |> build
      |> scale(5, 5)

    min = {0, 0}
    max = map |> List.last |> List.last |> elem(0)

    g = Graph.new
      |> Graph.add_edges(map |> edges())

    IO.inspect g

    path = Graph.new
      |> Graph.add_edges(map |> edges())
      |> Graph.dijkstra(min, max)
      |> List.delete_at(0)
    
    #render(map, path)

    Enum.reduce(path, 0, fn {x, y}, acc ->
      acc + (get(map, x, y) |> elem(1))
    end)
  end

end