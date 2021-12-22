defmodule Aoc2021.Day12Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day12

  @input [:code.priv_dir(:aoc2021), "day12.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split(~r/\R/, trim: true)

  describe "part one" do
    assert Day12.part_one(@input) == 5756
  end

  describe "part two" do
    assert Day12.part_two(@input) == 144603
  end

end