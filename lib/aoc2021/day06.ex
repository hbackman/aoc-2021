defmodule Aoc2021.Day06 do

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def tick(fish, days) when days > 0 do
    c = fish
      |> Enum.filter(fn a -> 0 == a end)
      |> Enum.map(fn _ -> 8 end)

    p = Enum.map(fish, fn a
      -> cond do
        a >= 1 -> a - 1
        a == 0 -> a + 6
      end
    end)

    tick(p ++ c, days - 1)
  end

  def tick(fish, days) when days <= 0 do
    fish
  end

  def part_one (input) do
    tick(input, 80)
      |> Enum.count()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two (_input) do
    :ok
  end

end