defmodule Aoc2021.Day02 do

  def split(instruction) do
    String.split(instruction, " ", trim: true)
      |> List.to_tuple()
      |> cast()
  end

  def cast({ins, val}) do
    {int, _  } = Integer.parse(val)
    {ins, int}
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def solve1([inst | instructions], {x, y}) do
    case split(inst) do
      {"forward", v} -> solve1(instructions, {x+v, y})
         {"down", v} -> solve1(instructions, {x, y+v})
           {"up", v} -> solve1(instructions, {x, y-v})
    end
  end

  def solve1([], {x, y}) do
    {x, y}
  end

  def part_one (input) do
    {x, y} = solve1(input, {0, 0})
    x * y
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def solve2([inst | instructions], aim, pos) do
    {xpos, ypos} = pos
    
    case split(inst) do
           {"up", v} -> solve2(instructions, aim-v, pos)
         {"down", v} -> solve2(instructions, aim+v, pos)
      {"forward", v} -> solve2(instructions, aim+0, { xpos + v, ypos + (aim * v)})
    end
  end

  def solve2([], _, pos) do
    pos
  end

  def part_two (input) do
    {x, y} = solve2(input, 0, {0, 0})
    x * y
  end

end