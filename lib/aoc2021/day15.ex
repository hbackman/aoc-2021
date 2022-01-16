defmodule Aoc2021.Day15 do

  alias Graph

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def render(map, highlight \\ [])
  def render(map, highlight) do
    for y <- 0..(-1 + Enum.count(map)) do
    for x <- 0..(-1 + Enum.count(map |> Enum.at(y))) do
      if Enum.member?(highlight, {x, y}) do
        IO.write '#'
      else
        IO.write (map
          |> Enum.at(y) 
          |> Enum.at(x))
      end
    end
      IO.puts ""
    end
  end

  def get(map, x, y) do
    map
      |> Enum.at(y)
      |> Enum.at(x)
  end
  
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

  def build(input) do
    map = input
      |> String.split(~r/\R/, trim: true)
      |> Enum.map(&(String.split(&1, "", trim: true)))

    for y <- 0..(-1 + Enum.count(map)) do
    for x <- 0..(-1 + Enum.count(map |> Enum.at(y))) do
      get(map, x, y)
        |> String.to_integer
    end
    end
  end

  def edges(map, pos) do
    {x, y} = pos
    edges = [
      {x-1, y}, {x, y-1},
      {x+1, y}, {x, y+1},
    ]
    edges |> Enum.filter(&(inside?(map, &1)))
  end

  def solve(map, pos, cost, visited \\ [])
  def solve(map, pos, cost, visited) do
    # Find all the edges and remove any that we either
    # have visited or is out of bounds.
    edges = edges(map, pos)
    risks = edges
      |> Enum.filter(&(Enum.member?(visited, &1) == false))
      |> Enum.map(fn pos ->
        {pos, get(map,
          elem(pos, 0),
          elem(pos, 1))}
      end)
      |> Enum.sort_by(&(elem(&1, 1)), :asc)
  end

  def part_one (input) do
    input
      |> build()
      |> solve({0, 0}, 0)
  end

end