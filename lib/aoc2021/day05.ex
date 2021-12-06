defmodule Aoc2021.Day05 do

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def parse(string) do
    string
      |> String.split(" -> ", trim: true)
      |> Enum.map(fn item
        -> item
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
      end)
  end

  def format(pos) do
    Enum.map(pos, fn p
      -> Enum.join(p, ",")
    end)
  end

  """
  """
  def draw(pos1, pos2) do
    [x1, y1] = pos1
    [x2, y2] = pos2

    if (pos1 == pos2) do
      [pos1]
    else
      dx = cond do
        x1 < x2 -> +1
        x1 > x2 -> -1
        true     -> 0
      end
      dy = cond do
        y1 < y2 -> +1
        y1 > y2 -> -1
        true    ->  0
      end
      [pos1 | draw([x1 + dx, y1 + dy], pos2)]
    end
  end

  """
  """
  def get_num_overlapping([line | lines], map) do
    [[x1, y1],
     [x2, y2]] = line

    path = draw([x1, y1], [x2, y2])
      |> format()

    get_num_overlapping(lines, map ++ path)
  end

  def get_num_overlapping([], map) do
    map -- (map |> Enum.uniq()) |> Enum.uniq()
      |> Enum.count()
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one (input) do
    input
      |> Enum.map(&parse/1)
      |> Enum.filter(fn [[x1, y1], [x2, y2]]
        -> cond do
          x1 == x2 -> true
          y1 == y2 -> true
          true     -> false
        end
      end)
      |> get_num_overlapping([])
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two (input) do
    input
      |> Enum.map(&parse/1)
      |> get_num_overlapping([])
  end

end