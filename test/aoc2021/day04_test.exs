defmodule Aoc2021.Day04Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day04

  @input [:code.priv_dir(:aoc2021), "day04.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split("\r\n\r\n", trim: true)

  describe "part one" do
    assert Day04.part_one(@input) == 44736
  end

  describe "part two" do
    assert Day04.part_two(@input) == 1827
  end

end