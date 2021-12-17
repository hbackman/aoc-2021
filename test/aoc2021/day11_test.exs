defmodule Aoc2021.Day11Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day11

  @input [:code.priv_dir(:aoc2021), "day11.txt"]
    |> Path.join()
    |> File.read!()
    |> String.replace(~r/\R/, "")
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(10)

  describe "part one" do
    assert Day11.part_one(@input) == 1599
  end

  describe "part two" do
    assert Day11.part_two(@input) == 418
  end

end