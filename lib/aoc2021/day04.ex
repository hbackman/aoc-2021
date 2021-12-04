defmodule Aoc2021.Day04 do

  # Utils

  def transpose(m) do
    m |> List.zip
      |> Enum.map(&Tuple.to_list/1)
  end

  def get_rows(board) do
    board
  end

  def get_cols(board) do
    board
      |> transpose()
  end

  def check_board(board, numbers) do
    sequences =
      get_rows(board) ++
      get_cols(board)

    Enum.reduce(sequences, false, fn seq, acc
      -> check_sequence(seq, numbers) || acc
    end)
  end

  def check_sequence([head | tail], numbers) do
    if (Enum.member?(numbers, head)) do
      check_sequence(tail, numbers)
    else
      false
    end
  end

  def check_sequence([], _numbers) do
    true
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def parse_numbers(input) do
    [numbers | _] = input
    numbers
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  def parse_boards(input) do
    [_ | boards] = input
    boards
      |> Enum.map(fn b
        -> String.split(b, "\r\n", trim: true)
          |> Enum.map(fn r
            -> String.split(r, " ", trim: true)
              |> Enum.map(&String.to_integer/1)
          end)
      end)
  end

  def search_first_winner(boards, [curr | pool], history) do

    hist = [curr | history]

    winner = Enum.find(boards, fn b
      -> check_board(b, hist)
    end)

    if winner do
      score = winner
        |> List.flatten()
        |> Enum.reject(fn n -> Enum.member?(hist, n) end)
        |> Enum.sum()
      score * curr
    else
      search_first_winner(boards, pool, hist)
    end
  end

  def part_one (input) do
    search_first_winner(
      parse_boards(input),
      parse_numbers(input), []
    )
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def search_last_winner(boards, [curr | pool], history, scores) do

    hist = [curr | history]

    winner = boards
      |> Enum.find(fn b -> check_board(b, hist) end)

    loosers = boards
      |> Enum.reject(fn b -> check_board(b, hist) end)

    if winner do
      score = winner
        |> List.flatten()
        |> Enum.reject(fn n -> Enum.member?(hist, n) end)
        |> Enum.sum()
        |> Kernel.*(curr)

      search_last_winner(loosers, pool, hist, [score | scores])
    else
      search_last_winner(loosers, pool, hist, scores)
    end
  end

  def search_last_winner([], _pool, _history, scores) do
    [score | _] = scores
    score
  end

  def part_two (input) do
    search_last_winner(
      parse_boards(input),
      parse_numbers(input), [], []
    )
  end

end