defmodule Aoc2021.Day03 do

  use Bitwise

  def split(s) do
    s |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  def transpose(m) do
    m |> List.zip
      |> Enum.map(&Tuple.to_list/1)
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def get_char(value, flip) do
    if flip do
      value ^^^ 1
    else
      value
    end
  end

  def get_stat([head | tail], acc, flip) do
    sum = Enum.sum(head)
    len = Enum.count(head)
    cond do
      sum > len/2 -> get_stat(tail, acc++[get_char(1, flip)], flip)
      sum < len/2 -> get_stat(tail, acc++[get_char(0, flip)], flip)
    end
  end

  def get_stat([], acc, _flip) do
    acc
      |> Enum.join()
      |> String.to_integer(2)
  end

  def part_one (input) do
    diagnostics = input
      |> Enum.map(&split/1)
      |> transpose()

    gam = get_stat(diagnostics, [], false)
    eps = get_stat(diagnostics, [], true)
    eps * gam
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two (_input) do
    :ok
  end

end