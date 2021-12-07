defmodule Aoc2021.Day06Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day06

  @input [:code.priv_dir(:aoc2021), "day06.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)

  describe "part one" do
    assert Day06.part_one(@input) == 380243
  end
  
  describe "part two" do
    assert Day06.part_two(@input) == :ok
  end

end