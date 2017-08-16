class Board
  attr_reader :rows, :cols, :board

  def initialize
    @rows = 6
    @cols = 7
    @board = reset_board
  end

  def drop_mark!(col, mark)
    row = @rows - 1
    placed = false

    while !placed && row >= 0 && is_valid_column?(col) do
      if @board[row][col] == ' '
        @board[row][col] = mark
        placed = true
      end

      row -= 1
    end
  end

  def four_in_a_row?
    @board.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        unless col == " "
          return true if four_right?(row_idx, col_idx)
          return true if four_up?(row_idx, col_idx)
          return true if four_diagonally_up_left?(row_idx, col_idx)
          return true if four_diagonally_up_right?(row_idx, col_idx)
        end
      end
    end

    false
  end

  def is_column_full?(col)
    6.times do |row|
      return false if @board[row][col] == ' '
    end
  end

  def is_board_full?
    @board.each do |row|
      row.each do |col|
        return false if col == ' '
      end
    end

    true
  end

  def to_s
    display = ""

    @board.each do |row|
      row.each do |col|
        display += "| #{col} "
      end
      display += "|\n"
      display += "+- -+- -+- -+- -+- -+- -+- -+\n"
    end

    display += "  1   2   3   4   5   6   7   \n"
  end

  private

  def reset_board
    @board = Array.new(@rows) { Array.new(@cols, ' ') }
  end

  def is_valid_column?(col)
    col >= 0 && col <= 6
  end

  def four_right?(row, col)
    mark = @board[row][col]

    3.times do
      col += 1

      return false if col >= @cols
      return false if @board[row][col] != mark
    end

    true
  end

  def four_up?(row, col)
    mark = @board[row][col]

    3.times do
      row -= 1

      return false if rows < 0
      return false if @board[row][col] != mark
    end

    true
  end

  def four_diagonally_up_left?(row, col)
    mark = @board[row][col]

    3.times do
      col -= 1
      row -= 1

      return false if col < 0 || row < 0
      return false if @board[row][col] != mark
    end

    true
  end

  def four_diagonally_up_right?(row, col)
    mark = @board[row][col]

    3.times do
      col += 1
      row -= 1

      return false if col >= @cols || row < 0
      return false if @board[row][col] != mark
    end

    true
  end
end
