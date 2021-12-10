defmodule Aoc2021.Day08Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day08

  @input [:code.priv_dir(:aoc2021), "day08.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split(~r/\R/, trim: true)

  describe "part one" do
    assert Day08.part_one(@input) == 365
  end

  describe "part two" do
    assert Day08.part_two(@input) == :skip
  end

end
