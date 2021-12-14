defmodule Aoc2021.Day09 do

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  @mapW 100
  @mapH 100

  defp in_map(x, y) do
    (x >= 0 and x < @mapW) and
    (y >= 0 and y < @mapH)
  end

  defp get_point(map, x, y) do
    map
      |> Enum.at(y)
      |> Enum.at(x)
  end

  defp get_nearby(map, x, y) do
    points = [
      [x + 1, y],
      [x - 1, y],
      [x, y - 1],
      [x, y + 1]
    ]
    points
      |> Enum.filter(fn [px, py] -> in_map(px, py) end)
      |> Enum.map(fn [px, py] -> get_point(map, px, py) end)
  end

  defp get_tubes(map) do
    for y <- Enum.to_list(0..@mapH-1) do
    for x <- Enum.to_list(0..@mapW-1) do
      p1 = get_point(map, x, y)
      pn = get_nearby(map, x, y)
        |> Enum.min()

      if p1 < pn do p1 else nil end
    end
    end
  end

  def part_one (input) do
    get_tubes(input)
      |> List.flatten()
      |> Enum.reject(&(&1 == nil))
      |> Enum.map(&(&1 + 1))
      |> Enum.sum()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------
  
  def part_two (input) do
  end

end