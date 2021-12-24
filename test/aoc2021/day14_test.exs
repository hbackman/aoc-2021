defmodule Aoc2021.Day14Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day14

  @input [:code.priv_dir(:aoc2021), "day14.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split(~r/\R/, trim: true)

  describe "part one" do
    #assert Day14.part_one(@input) == 2584
  end

  describe "part two" do
    IO.inspect Day14.part_two(@input)
  end

end