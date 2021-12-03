defmodule Aoc2021.Day02Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day02

  @input [:code.priv_dir(:aoc2021), "day02.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split("\r\n", trim: true)

  describe "part one" do
    #assert Day02.part_one(@input) == 1670340
  end

  describe "part two" do
    IO.inspect Day02.part_two(@input)
  end

end