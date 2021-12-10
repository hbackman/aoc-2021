defmodule Aoc2021.Day09Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day09

  @input [:code.priv_dir(:aoc2021), "day09.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split(~r/\R/, trim: true)

  describe "part one" do
    IO.inspect Day09.part_one(@input)
  end

end