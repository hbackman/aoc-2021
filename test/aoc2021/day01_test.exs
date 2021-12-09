defmodule Aoc2021.Day01Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day01

  @input [:code.priv_dir(:aoc2021), "day01.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split(~r/\R/, trim: true)
    |> Enum.map(&String.to_integer/1)

  describe "part one" do
    assert Day01.part_one(@input) == 1655
  end

  describe "part two" do
    assert Day01.part_two(@input) == 1683
  end

end
