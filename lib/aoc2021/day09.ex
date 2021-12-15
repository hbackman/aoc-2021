defmodule Aoc2021.Day09 do

  @mapW 100
  @mapH 100

  defp in_map(x, y) do
    (x >= 0 and x < @mapW) and
    (y >= 0 and y < @mapH)
  end

  defp get_height(map, x, y) do
    map
      |> Enum.at(y)
      |> Enum.at(x)
  end

  defp get_nearby(map, x, y) do
    nearby = [
      {x+1, y}, {x-1, y},
      {x, y+1}, {x, y-1}
    ]
    Enum.filter(nearby, fn {px, py} -> in_map(px, py) end)
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def get_drainmap(map) do
    for y <- Enum.to_list(0..@mapH-1) do
    for x <- Enum.to_list(0..@mapW-1) do
      p1 = get_height(map, x, y)
      pn = get_nearby(map, x, y)
        |> Enum.map(fn {px, py} -> get_height(map, px, py) end)
        |> Enum.min()

      if p1 < pn do {x, y} else nil end
    end
    end
  end

  def get_drains(map) do
    get_drainmap(map)
      |> List.flatten()
      |> Enum.reject(&is_nil/1)
  end

  def part_one (input) do
    get_drains(input)
      |> Enum.map(fn {x, y} -> get_height(input, x, y) + 1 end)
      |> Enum.sum()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  defp search(map, {x, y}, explored) do
    height = get_height(map, x, y)
    nearby = get_nearby(map, x, y)
    larger = nearby
      |> Enum.filter(fn {px, py} -> in_map(px, py) end)
      |> Enum.filter(fn {px, py} ->
        get_height(map, px, py) > height and
        get_height(map, px, py) < 9
      end)

    if length(larger) <= 0 do
      explored
    else
      larger
        |> Enum.map(fn p -> search(map, p, [p | explored]) end)
        |> Enum.concat()
    end
  end

  def get_basin_sizes(map) do
    get_drains(map)
      |> Enum.map(fn p -> search(map, p, [p])
          |> Enum.uniq()
          |> Enum.count()
      end)
  end
  
  def part_two (input) do
    get_basin_sizes(input)
      |> Enum.sort(&(&1 >= &2))
      |> Enum.take(3)
      |> Enum.reduce(fn (size, acc) -> acc * size end)
  end

end