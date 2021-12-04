defmodule Aoc2021.Day03Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day03

  @input [:code.priv_dir(:aoc2021), "day03.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split("\r\n", trim: true)

  describe "part one" do
    assert Day03.part_one(@input) == 3633500
  end

  describe "part two" do
    assert Day03.part_two(@input) == :ok
  end

end