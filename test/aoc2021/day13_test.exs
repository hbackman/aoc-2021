defmodule Aoc2021.Day13Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day13

  @input [:code.priv_dir(:aoc2021), "day13.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    #assert Day13.part_one(@input) == 788
  end

  describe "part two" do
    IO.inspect Day13.part_two(@input)
  end

end