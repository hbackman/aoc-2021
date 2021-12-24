defmodule Aoc2021.Day14 do

  defp parse(input) do
    s = fn rules ->
      Enum.map(rules, &(String.split(&1, " -> ", trim: true)))
    end
    [template | rules] = input
    {template, s.(rules)}
  end

  defp insert(polymer, rules) do
    # Find all the rules that matches the input string.
    rules = Enum.filter(rules, fn [from, _]
      -> String.contains?(polymer, from)
    end)
    # Find all the replacements that we have to do. Then we
    # need to sort them to avoid messing up indices.
    replacements = Enum.reduce(rules, [], fn [from, to], acc
      # Find all occurrences of the polymer rule, then
      # map the matches into insert rules.
      -> {_, rx} = Regex.compile("(?=" <> from <> ")")
         matches = Regex.scan(rx, polymer, return: :index)
           |> List.flatten()
           |> Enum.map(fn {idx, _} ->
                {idx + 1, to, from}
              end)
         matches ++ acc
    end)

    replacements = Enum.sort_by(replacements, &(elem(&1, 0)), :desc)
    replacements |> Enum.reduce(polymer, fn {idx, char, _}, acc
      -> acc
        |> String.split("", trim: true)
        |> List.insert_at(idx, char)
        |> Enum.join("")
    end)
  end

  defp run(str, rules, n) when n > 0 do

    IO.puts n

    str = insert(str, rules)
    run(str, rules, n - 1)
  end

  defp run(str, _rules, n) when n <= 0 do
    str
  end

  defp solve(str) do
    elements = str
      |> String.split("", trim: true)
      |> Enum.uniq()
      |> Enum.map(fn char
        -> count = str |> String.graphemes |> Enum.count(& &1 == char)
           {char, count}
      end)
    elements = Enum.sort_by(elements, &(elem(&1, 1)), :desc)

    {_, f} = elements |> List.first()
    {_, l} = elements |> List.last()

    f - l
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one (input) do
    {template, rules} = parse(input)
    
    polymer = run(template, rules, 10)
    polymer |> solve()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two (input) do
    {template, rules} = parse(input)
    
    polymer = run(template, rules, 40)
    polymer |> solve()
  end

end