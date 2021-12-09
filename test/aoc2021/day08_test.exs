defmodule Aoc2021.Day08Test do

  use ExUnit.Case, async: true

  alias Aoc2021.Day08

  @input [:code.priv_dir(:aoc2021), "day08.txt"]
    |> Path.join()
    |> File.read!()
    |> String.split(~r/\R/, trim: true)

  describe "part one" do
    IO.inspect Day08.part_one(@input)
  end

end
