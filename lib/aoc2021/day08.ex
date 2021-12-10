defmodule Aoc2021.Day08 do

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp count_known_signals(patterns) do
    patterns
      |> Enum.filter(fn p
        -> case String.length(p) do
            2 -> true
            4 -> true
            3 -> true
            7 -> true
            _ -> false
        end
      end)
      |> Enum.count()
  end

  def part_one (input) do
    map = fn i ->
      i
        |> String.split("|") |> Enum.at(1)
        |> String.split(" ", trim: true)
        |> count_known_signals()
    end

    input
      |> Enum.map(map)
      |> Enum.sum()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two (_input) do
    :skip
  end

end