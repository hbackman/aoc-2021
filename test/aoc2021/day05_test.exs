defmodule Aoc2021.Day05Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day05

  @input [:code.priv_dir(:aoc2021), "day05.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split("\r\n", trim: true)

  describe "part one" do
    assert Day05.part_one(@input) == 4421
  end

  describe "part two" do
    assert Day05.part_two(@input) == 18674
  end

end