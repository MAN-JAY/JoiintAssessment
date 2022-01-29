defmodule Exercise1Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Assessment.Constants
  alias Assessment.Exercise1

  describe "find word in a matrix" do
    setup do
      [
        rows: 2,
        columns: 2,
        board: [
          ['F', 'C'],
          ['D', 'E'],
        ],
        word1: ['F', 'C'],
        word2: ['E', 'D', 'F'],
        word3: ['E', 'F'],
        word4: ['A', 'F', 'G'],
      ]
    end

    test "recursion call should fail when row index is out of range", fixture do
      refute Exercise1.find_word(fixture.board, fixture.word1, {0, 1}, {-1, 1}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word1, {1, 1}, {2, 1}, {fixture.rows, fixture.columns}, 1)
    end

    test "recursion call should fail when column index is out of range", fixture do
      refute Exercise1.find_word(fixture.board, fixture.word1, {0, 1}, {0, 2}, {fixture.rows, fixture.columns}, 1)
      refute Exercise1.find_word(fixture.board, fixture.word1, {0, 0}, {0, -1}, {fixture.rows, fixture.columns}, 0)
    end

    test "return true when reached last letter of the word", fixture do
      assert Exercise1.find_word(fixture.board, fixture.word1, {0, 1}, {1, 1}, {fixture.rows, fixture.columns}, 2)
    end

    test "call recursion should return false if next index is same as previous index", fixture do
      refute Exercise1.call_recursion(fixture.board, fixture.word1, {0, 0}, {0, 1}, {0, 0}, {fixture.rows, fixture.columns}, 2)
    end

    test "word present in board in same row with start index", fixture do
      assert Exercise1.find_word(fixture.board, fixture.word1, {-1, -1}, {0, 0}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word1, {-1, -1}, {0, 1}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word1, {-1, -1}, {1, 0}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word1, {-1, -1}, {1, 1}, {fixture.rows, fixture.columns}, 0)
    end

    test "word present in board in different rows with start index", fixture do
      assert Exercise1.find_word(fixture.board, fixture.word2, {-1, -1}, {1, 1}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word2, {-1, -1}, {1, 0}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word2, {-1, -1}, {0, 1}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word2, {-1, -1}, {0, 0}, {fixture.rows, fixture.columns}, 0)
    end

    test "word not present in board in expected sequence with start index", fixture do
      refute Exercise1.find_word(fixture.board, fixture.word3, {-1, -1}, {0, 0}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word3, {-1, -1}, {0, 1}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word3, {-1, -1}, {1, 0}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word3, {-1, -1}, {1, 1}, {fixture.rows, fixture.columns}, 0)
    end

    test "letters of word not present in board with start index", fixture do
      refute Exercise1.find_word(fixture.board, fixture.word4, {-1, -1}, {0, 0}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word4, {-1, -1}, {1, 0}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word4, {-1, -1}, {0, 1}, {fixture.rows, fixture.columns}, 0)
      refute Exercise1.find_word(fixture.board, fixture.word4, {-1, -1}, {1, 1}, {fixture.rows, fixture.columns}, 0)
    end

    test "word present in board in same row without start index", fixture do
      assert Exercise1.find_word(fixture.board, fixture.word1, {fixture.rows, fixture.columns})
    end

    test "word present in board in different rows without start index", fixture do
      assert Exercise1.find_word(fixture.board, fixture.word2, {fixture.rows, fixture.columns})
    end

    test "word not present in board in expected sequence without start index", fixture do
      refute Exercise1.find_word(fixture.board, fixture.word3, {fixture.rows, fixture.columns})
    end

    test "letters of word not present in board without start index", fixture do
      refute Exercise1.find_word(fixture.board, fixture.word4, {fixture.rows, fixture.columns})
    end

  end

end
