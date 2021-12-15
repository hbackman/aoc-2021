defmodule Aoc2021.Day09Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day09

  @input [:code.priv_dir(:aoc2021), "day09.txt"]
    |> Path.join()
    |> File.read!()
    |> String.replace(~r/\R/, "")
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(100)

  describe "part one" do
    assert Day09.part_one(@input) == 550
  end

  describe "part two" do
    assert Day09.part_two(@input) == 1100682
  end

end