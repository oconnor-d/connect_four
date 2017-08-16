require "board"

describe Board do
  let(:board) { Board.new }

  describe "#initialize" do
    it "has 6 rows" do
      expect(board.rows).to eql(6)
    end

    it "has 7 columns" do
      expect(board.cols).to eql(7)
    end

    describe "2D array" do
      it "has 6 rows" do
        expect(board.board.length).to eql(6)
      end
      
      it "has 7 columns" do
        expect(board.board[0].length).to eql(7)
      end

      it "is filled with ''" do
        expect(board.board[0][0]).to eql(' ')
        expect(board.board[0][6]).to eql(' ')
        expect(board.board[3][4]).to eql(' ')
        expect(board.board[5][0]).to eql(' ')
        expect(board.board[5][6]).to eql(' ')
      end
    end
  end

  describe ".to_s" do
    it "returns a string" do
      expect(board.to_s).to be_instance_of(String)
    end
  end

  describe ".drop_mark" do
    before(:context) do
      @board1 = Board.new

      @board1.drop_mark!(0, 'X')
      @board1.drop_mark!(0, 'O')

      6.times do
        @board1.drop_mark!(6, 'X')
      end
    end
    
    context "given column 0, mark 'X' and the col 0, mark 'O'" do
      it "replaces the ' ' in the bottom row of the first col with 'X'" do
        expect(@board1.board[5][0]).to eql('X')
      end

      it "replaces the ' ' in the second to bottom row of the first col with 'O'" do
        expect(@board1.board[4][0]).to eql('O')
      end
    end

    context "given an invalid column" do
      it "does nothing when given a column less than 0" do
        @board1.drop_mark!(-1, 'X')
        expect(@board1.board[3][0]).to eql(' ')
      end

      it "does nothing when given a column greater than 6" do
        @board1.drop_mark!(7, 'X')
        expect(@board1.board[0][6]).to eql("X")
      end

      it "does nothing when there is no empty places in the given column" do
        @board1.drop_mark!(6, 'O')
        expect(@board1.board[0][6]).to eql("X")
      end
    end
  end

  describe ".four_in_a_row?" do
    context "there are four in a row" do
      it "returns true when there are four in a row horizontally" do
        h_board = Board.new
        h_board.drop_mark!(0, 'X')
        h_board.drop_mark!(1, 'X')
        h_board.drop_mark!(2, 'X')
        h_board.drop_mark!(3, 'X')

        expect(h_board.four_in_a_row?).to be(true)
      end

      it "returns true when there are four in a row vertically" do
        v_board = Board.new
        v_board.drop_mark!(3, 'X')
        v_board.drop_mark!(3, 'X')
        v_board.drop_mark!(3, 'X')
        v_board.drop_mark!(3, 'X')

        expect(v_board.four_in_a_row?).to be(true)
      end

      it "returns true when there are four in a row diagonally" do
        d_board = Board.new
        d_board.drop_mark!(0, 'X')
        d_board.drop_mark!(1, 'O')
        d_board.drop_mark!(1, 'X')
        d_board.drop_mark!(2, 'O')
        d_board.drop_mark!(2, 'O')
        d_board.drop_mark!(2, 'X')
        d_board.drop_mark!(3, 'O')
        d_board.drop_mark!(3, 'O')
        d_board.drop_mark!(3, 'O')
        d_board.drop_mark!(3, 'X')

        expect(d_board.four_in_a_row?).to be(true)
      end
    end

    context "there are not four in a row" do
      it "returns false when there are other marks in the path" do
        other_board = Board.new
        other_board.drop_mark!(0, 'X')
        other_board.drop_mark!(1, 'X')
        other_board.drop_mark!(2, 'O')
        other_board.drop_mark!(3, 'X')
        other_board.drop_mark!(4, 'X')

        expect(other_board.four_in_a_row?).to be(false)
      end

      it "returns false for an incomplete vertical row" do
        v_board = Board.new
        v_board.drop_mark!(0, 'X')
        v_board.drop_mark!(0, 'X')

        expect(v_board.four_in_a_row?).to be(false)
      end

      it "returns false for an incomplete horizontal row" do
        h_board = Board.new
        h_board.drop_mark!(0, 'X')
        h_board.drop_mark!(1, 'X')

        expect(h_board.four_in_a_row?).to be(false)
      end

      it "returns false for an incomplete diagonal row" do
        d_board = Board.new
        d_board.drop_mark!(0, 'X')
        d_board.drop_mark!(1, 'O')
        d_board.drop_mark!(1, 'X')
        d_board.drop_mark!(2, 'O')
        d_board.drop_mark!(2, 'O')
        d_board.drop_mark!(2, 'X')

        expect(d_board.four_in_a_row?).to be(false)
      end
    end
  end

  describe ".is_board_full?" do
    before do
      @full_board = Board.new

      @full_board.board.each_with_index do |row, r_idx|
        row.each_with_index do |col, c_idx|
          @full_board.board[r_idx][c_idx] = 'X'
        end
      end
    end

    it "returns true when it is full" do
      expect(@full_board.is_board_full?).to be(true)
    end

    it "returns false when it is almost full" do
      @full_board.board[0][0] = ' '
      expect(@full_board.is_board_full?).to be(false)
    end

    it "returns false when it is completely empty" do
      expect(Board.new.is_board_full?).to be(false)
    end
  end
end
