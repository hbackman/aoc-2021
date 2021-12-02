defmodule Aoc2021.Day01 do

  def count_dips([head | tail], last, count) do
    count_dips(tail, head, cond do
      head > last -> count + 1
      head < last -> count + 0
    end)
  end

  def count_dips([], _last, count) do
    count
  end

  def part_one (input) do
    [head | list] = input
    count_dips(list, head, 0)
  end

  # ------------------------------------------
  # 199  A
  # 200  A B
  # 208  A B C
  # 210    B C D
  # 200  E   C D
  # 207  E F
  # 240  E F G
  # 269    F G H
  # 260      G H
  # 263        H
  # ------------------------------------------
  # A: 607 (N/A)
  # B: 618 (increased)
  # C: 618 (no change)
  # D: 617 (decreased)
  # E: 647 (increased)
  # F: 716 (increased)
  # G: 769 (increased)
  # H: 792 (increased)
  # ------------------------------------------

  def smooth([], acc) do
    acc
  end

  def smooth(list, acc) do
    if length(list) <= 4 do
      []
    else
      [head | tail] = list
      IO.puts(head)

      smooth(tail, acc)
    end
  end

  def part_two (input) do
  
    smooth(input, [])
  end

end