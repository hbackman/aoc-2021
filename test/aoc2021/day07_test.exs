defmodule Aoc2021.Day07Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day07

  @input [:code.priv_dir(:aoc2021), "day07.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)

  describe "part one" do
    assert Day07.part_one(@input) == 352707
  end

  describe "part two" do
    assert Day07.part_two(@input) == 95519693
  end

end