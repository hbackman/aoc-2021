defmodule Aoc2021.Day10 do
  
  defp is_opening(char), do: char in ["{", "(", "[", "<"]
  defp is_closing(char), do: char in ["}", ")", "]", ">"]
  
  defp is_matching(ch1, ch2) do
    case ch1 do
      "{" -> ch2 == "}"
      "(" -> ch2 == ")"
      "[" -> ch2 == "]"
      "<" -> ch2 == ">"
        _ -> false
    end
  end

  defp get_matching(chr) do
    case chr do
      "{" -> "}"
      "(" -> ")"
      "[" -> "]"
      "<" -> ">"
        _ -> ""
    end
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp parse(symbols) do
    parse(String.split(symbols, "", trim: true), [""])
  end

  defp parse([ch1 | symbols], stack) do
    # First, pull out the head of the group stack.
    [st_head | st_tail] = stack
    # Next, determine whether it's an opening group, or
    # closing group.
    cond do
      is_opening(ch1) -> parse(symbols, [ch1 | stack])
      is_closing(ch1) ->
        # If it's closing, then it needs to match the last
        # opening symbol.
        if is_matching(st_head, ch1) do
          parse(symbols, st_tail)
        else
          # If it isn't, then the syntax is incorrect and
          # we should stop parsing the string.
          {:syntax_err, ch1}
        end
    end
  end

  defp parse([], stack) do
    if length(stack) do
      # If there's still items left in the stack, then not all
      # groups are closed. So the expression is incomplete.
      {:syntax_inc, stack}
    else
      # If not, then the syntax was parsed successfully.
      {:syntax_ok}
    end
  end

  defp score(char) do
    case char do
      ")" -> 3
      "]" -> 57
      "}" -> 1197
      ">" -> 25137
    end
  end

  def part_one (input) do
    input
      |> Enum.map(&parse/1)
      |> Enum.filter(&match?({:syntax_err, _}, &1))
      |> Enum.reduce(
        0, fn {_, ch}, acc -> acc + score(ch) end)
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  defp autocomplete(symbols) do
    case parse(symbols) do
      {:syntax_ok    } -> nil
      {:syntax_err, _} -> nil
      {:syntax_inc, s} -> Enum.map(s, &get_matching/1) |> Enum.join()
    end
  end

  defp ch_score(chr) do
    case chr do
      ")" -> 1
      "]" -> 2
      "}" -> 3
      ">" -> 4
    end
  end

  defp ac_score(str) when str == nil do
    nil
  end

  defp ac_score(str) do
    str
      |> String.split("", trim: true)
      |> Enum.reduce(0, fn ch, acc -> (acc * 5) + ch_score(ch) end)
  end
  
  def part_two (input) do
    scores = input
      |> Enum.map(&autocomplete/1)
      |> Enum.map(&ac_score/1)
      |> Enum.filter(& &1)
      |> Enum.sort()
    
    Enum.at(scores, length(scores) |> div(2))
  end

end