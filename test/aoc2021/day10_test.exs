defmodule Aoc2021.Day10Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day10

  @input [:code.priv_dir(:aoc2021), "day10.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split(~r/\R/, trim: true)

  describe "part one" do
    assert Day10.part_one(@input) == 339537
  end

  describe "part two" do
    assert Day10.part_two(@input) == 2412013412
  end

end