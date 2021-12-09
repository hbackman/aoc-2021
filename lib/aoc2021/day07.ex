  defmodule Aoc2021.Day07 do

  defp range(input) do
    min = Enum.min(input)
    max = Enum.max(input)
    min..max
      |> Enum.to_list()
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp calculate_cost([ p1 | positions ], p2, cost) do
    calculate_cost(positions, p2, cost + abs(p1 - p2))
  end

  defp calculate_cost([], _, cost) do
    cost
  end

  def part_one (input) do
    range(input)
      |> Enum.map(fn p -> calculate_cost(input, p, 0) end)
      |> Enum.min()
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp calculate_cost_2([ p1 | positions ], p2, acc) do
    curr = 1..abs(p1 - p2)
      |> Enum.to_list()
      |> Enum.sum()

    calculate_cost_2(positions, p2, acc + curr)
  end

  defp calculate_cost_2([], _, acc) do
    acc
  end

  def part_two (input) do
    range(input)
      |> Enum.map(fn p -> calculate_cost_2(input, p, 0) end)
      |> Enum.min()
  end

end
