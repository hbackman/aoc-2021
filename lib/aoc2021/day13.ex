defmodule Aoc2021.Day13 do
  
  defp parse(input) do
    [ds, fs] = String.split(input, ~r/\R\R/)
    %{
      # Find all dots by scanning the input for "x,y", then
      # cast them properly.
      ds: Regex.scan(~r/(\d*),(\d*)/, ds, capture: :all_but_first)
        |> List.flatten()
        |> Enum.map(&String.to_integer/1)
        |> Enum.chunk_every(2),

      fs: Regex.scan(~r/(\w)=(\d*)/, fs, capture: :all_but_first)
        |> Enum.map(
          fn [a, v] -> [String.to_atom(a), String.to_integer(v)] end),
    }
  end

  defp paper_size(paper) do
    xs = Enum.map(paper, fn {x, _} -> x end)
    ys = Enum.map(paper, fn {_, y} -> y end)
    {
      Enum.max(xs),
      Enum.max(ys)
    }
  end

  #
  defp paper_make(dots, cursor, paper \\ [])
  defp paper_make([h|t], {x, y}, paper) do
    [dx, dy] = h
    {px, py} = {x + dx, y + dy}

    paper_make(t, {x, y}, [{px, py} | paper])
  end

  defp paper_make([], _, paper) do
    paper
  end

  #
  defp paper_fold(paper, :y, p) do
    inner = Enum.filter(paper, fn {_, y} -> y < p end)
    outer = Enum.filter(paper, fn {_, y} -> y > p end)
      |> Enum.map(fn {x, y} ->
        {x, p-(y-p)}
      end)

    inner ++ outer |> Enum.uniq()
  end

  defp paper_fold(paper, :x, p) do
    inner = Enum.filter(paper, fn {x, _} -> x < p end)
    outer = Enum.filter(paper, fn {x, _} -> x > p end)
      |> Enum.map(fn {x, y} ->
        {p-(x-p), y}
    end)

    inner ++ outer |> Enum.uniq()
  end

  #
  defp paper_echo(paper) do
    {sx, sy} = paper_size(paper)

    for y <- 0..sy do
    for x <- 0..sx do
      if Enum.member?(paper, {x, y}) do
        IO.write '#'
      else
        IO.write '.'
      end
    end
      IO.puts ""
    end
    nil
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one (input) do
    parsed = parse(input)

    dots = parsed.ds
    fold = parsed.fs
      |> Enum.at(0)

    [fold_dir,
     fold_val] = fold

    paper = dots
      |> paper_make({0, 0})
      |> paper_fold(fold_dir, fold_val)
      
    length(paper)
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two (input) do
    input = parse(input)
    paper = paper_make(input.ds, {0, 0})

    Enum.reduce(input.fs, paper, fn [fd, fv], paper -> 
      paper_fold(paper, fd, fv)
    end)
      |> paper_echo()
  end

end