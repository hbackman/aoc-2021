defmodule Aoc2021.Day11 do

  defguard in_map(x, y) when
    (x >= 0 and x < 10) and
    (y >= 0 and y < 10)

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp inc(map, x, y) do
    eng = get(map, x, y)

    if eng > 0 do
      set(map, x, y, eng + 1)
    else
      map
    end
  end

  defp get(map, x, y) when in_map(x, y) do
    map
      |> Enum.at(y)
      |> Enum.at(x)
  end

  defp set(map, x, y, v) when in_map(x, y) do 
    row = map
      |> Enum.at(y)
      |> List.replace_at(x, v)
    map
      |> List.replace_at(y, row)
  end

  defp get(_mp, _, _   ), do: 0
  defp set(map, _, _, _), do: map

  #

  defp flash(map, {x, y}) do
    out = map
      |> set(x, y, 0)

      |> inc(x-1, y+1) |> inc(x-1, y+0) |> inc(x-1, y-1)
      |> inc(x+1, y+1) |> inc(x+1, y+0) |> inc(x+1, y-1)
      |> inc(x+0, y+1) |> inc(x+0, y-1)
  end

  defp count_flashes(map, steps, flashes \\ 0)
  defp count_flashes(map, steps, flashes) when steps > 0 do
    [next_map, curr_flashes] = map
      |> tick_age()
      |> tick_flashes()

    count_flashes(next_map, steps - 1, curr_flashes + flashes)
  end

  defp count_flashes(_map, _steps, flashes) do
    flashes
  end

  defp tick_age(map) do
    for y <- 0..9 do
    for x <- 0..9 do
      get(map, x, y) + 1
    end
    end
  end

  defp tick_flashes(map, flashes \\ 0)
  defp tick_flashes(map, flashes) do
    # First, get all charted octopi, then reduce their flashes. 
    rdy = find_charged(map)
    aft = rdy
      |> Enum.reduce(map, fn pos, acc ->
        flash(acc, pos)
      end)
    # As long as there's still ready octopi on the map, we
    # should keep going.
    if length(rdy) > 0 do
      tick_flashes(aft, flashes + length(rdy))
    else
      [map, flashes]
    end
  end

  defp find_charged(map) do
    charged =
      for y <- 0..9 do
      for x <- 0..9 do
        if get(map, x, y) > 9 do {x, y} else nil end
      end
      end
    charged
      |> List.flatten()
      |> Enum.filter(& &1)
  end

  def part_one (input) do
    input |> count_flashes(100)
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  defp find_synchronized_step(map, step \\ 0)
  defp find_synchronized_step(map, step) do
    # The first thing we need to do is to check if the
    # map is already synchronized.
    is_synchronized = map
      |> List.flatten()
      |> Enum.uniq()
      |> Enum.count()
      |> Kernel.<=(1)

    # If it is, great, then return the step.
    if is_synchronized do
      step
    # If it's not, keep going until it finally is.
    else
      [next_map, _] = map
        |> tick_age()
        |> tick_flashes()

      find_synchronized_step(next_map, step + 1)
    end
  end

  def part_two (input) do
    input |> find_synchronized_step()
  end

end