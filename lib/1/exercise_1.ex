defmodule Assessment.Exercise1 do
  defguard in_range(i, m) when i >= 0 and i < m
  defguard is_last(word, index) when index == length(word)

  def init() do
    Assessment.Utils.frame()
    IO.puts("\n EXERCISE 1\n")

    {rows, columns} = get_board_size()
    board = get_board(rows)

    begin_find(board, rows, columns)
  end

  def begin_find(board, rows, columns) do
    Assessment.Utils.frame()
    IO.puts("\n EXERCISE 1\n")

    display_board(board)

    [input] =
      IO.gets("Enter '1' to search a word in the board, to quit enter other key\n")
      |> String.split([" ", "\n"], trim: true)

    case input do
      "1" ->
        word = read_word()

        cond do
          length(word) > rows * columns ->
            IO.gets("\nEntered in longer than grid size\n")

          find_word(board, word, {rows, columns}) ->
            ["\n", "Given word- '", word, "' is present in the board", "\n"]
            |> Enum.join()
            |> IO.gets()

          true ->
            ["\n", "Given word- '", word, "' is not present in the board", "\n"]
            |> Enum.join()
            |> IO.gets()
        end

        begin_find(board, rows, columns)

      _ ->
        [IO.ANSI.clear(), IO.ANSI.cursor(1, 1), 'Application Closed\n']
        |> Enum.join()
        |> IO.write()
    end
  end

  def get_all_starts(board, start_char) do
    board
    |> Enum.with_index(fn row, x_index ->
      Enum.with_index(row, fn element, y_index ->
        {{x_index, y_index}, element}
      end)
    end)
    |> List.flatten()
    |> Enum.reduce([], fn {cell, element}, acc ->
      if element == start_char, do: acc ++ [cell], else: acc
    end)
  end

  def read_word() do
    IO.gets("\nEnter the word\n")
    |> to_string()
    |> String.split(["\n"], trim: true)
    |> hd()
    |> String.split("", trim: true)
    |> Enum.map(fn c -> String.to_charlist(c) end)
  end

  def get_board(rows) do
    ["\n", "Enter the board", "\n"] |> Enum.join() |> IO.write()

    IO.stream(:stdio, :line)
    |> Stream.take_while(&(&1 != "\n"))
    |> Enum.take(rows)
    |> Enum.map(fn row_data ->
      String.split(row_data, [" ", "\n"], trim: true) |> Enum.map(&to_charlist(&1))
    end)
  end

  def get_board_size() do
    [r, c] =
      ["\n", "Enter number of rows and columns in format -> rows colums", "\n"]
      |> Enum.join()
      |> IO.gets()
      |> String.split([",", " ", "\n"], trim: true)

    {rows, _} = Integer.parse(r)
    {columns, _} = Integer.parse(c)

    {rows, columns}
  end

  def find_word(board, word, {rows, columns}) do
    board
    |> get_all_starts(Enum.at(word, 0))
    |> Enum.map(fn cell ->
      find_word(board, word, {-1, -1}, cell, {rows, columns}, 0)
    end)
    |> Enum.count(&(&1 == true)) > 0
  end

  def find_word(_board, word, _prev_cell, _curr_cell, _board_size, index)
      when is_last(word, index),
      do: true

  def find_word(_board, _word, _prev_cell, {x, y}, {m, n}, _index)
      when not in_range(x, m) or not in_range(y, n),
      do: false

  def find_word(board, word, {a, b}, {x, y}, {m, n}, index) do
    val = board |> Enum.at(x) |> Enum.at(y)

    if val != Enum.at(word, index) do
      false
    else
      call_recursion(board, word, {a, b}, {x, y}, {x + 1, y}, {m, n}, index + 1) ||
        call_recursion(board, word, {a, b}, {x, y}, {x - 1, y}, {m, n}, index + 1) ||
        call_recursion(board, word, {a, b}, {x, y}, {x, y + 1}, {m, n}, index + 1) ||
        call_recursion(board, word, {a, b}, {x, y}, {x, y - 1}, {m, n}, index + 1)
    end
  end

  def call_recursion(board, word, {a, b}, {x, y}, {xn, yn}, {m, n}, n_index),
    do:
      if(!(xn == a && yn == b),
        do: find_word(board, word, {x, y}, {xn, yn}, {m, n}, n_index),
        else: false
      )

  defp display_board(board) do
    IO.write("\n")

    board
    |> Enum.map(fn row ->
      Enum.map(row, &([&1, ' '] |> Enum.join() |> IO.write()))
      IO.write("\n")
    end)

    IO.write("\n\n")
  end
end
