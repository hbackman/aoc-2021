defmodule Aoc2021.Day15Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day15

  @input [:code.priv_dir(:aoc2021), "day15.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    IO.inspect Day15.part_one(@input)
  end

end