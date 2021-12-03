defmodule Aoc2021.Day01 do

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def count_dips([head | tail], last, count) do
    count_dips(tail, head, cond do
      head >  last -> count + 1
      head <= last -> count + 0
    end)
  end

  def count_dips([], _last, count) do
    count
  end

  def part_one (input) do
    [head | list] = input
    count_dips(list, head, 0)
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def smooth([a, b, c | list], acc) do
    smooth([b, c | list], acc ++ [a + b + c])
  end

  def smooth([_, _], acc) do
    acc
  end

  def part_two (input) do
    input
      |> smooth([])
      |> part_one()
  end

end