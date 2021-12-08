defmodule Aoc2021.Day06 do

  defp init(fish) do
    [
      fish |> Enum.filter(fn age -> age == 0 end) |> Enum.count(),
      fish |> Enum.filter(fn age -> age == 1 end) |> Enum.count(),
      fish |> Enum.filter(fn age -> age == 2 end) |> Enum.count(),
      fish |> Enum.filter(fn age -> age == 3 end) |> Enum.count(),
      fish |> Enum.filter(fn age -> age == 4 end) |> Enum.count(),
      fish |> Enum.filter(fn age -> age == 5 end) |> Enum.count(),
      fish |> Enum.filter(fn age -> age == 6 end) |> Enum.count(),
      fish |> Enum.filter(fn age -> age == 7 end) |> Enum.count(),
      fish |> Enum.filter(fn age -> age == 8 end) |> Enum.count(),
    ]
  end

  defp age(fish) do
    [f0, f1, f2, f3, f4, f5, f6,      f7, f8] = fish
    [f1, f2, f3, f4, f5, f6, f7 + f0, f8, f0]
  end

  defp tick(fish, days) when days > 0 do
    tick(age(fish), days-1)
  end

  defp tick(fish, days) when days <= 0 do
    fish
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one (input) do
    input
      |> init()
      |> tick(80)
      |> Enum.sum()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two (input) do
    input
      |> init()
      |> tick(256)
      |> Enum.sum()
  end

end
