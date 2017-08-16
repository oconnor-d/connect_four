require_relative "./player"
require_relative "./board"

class ConnectFour
  attr_reader :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new("\u25CB")
    @player2 = Player.new("\u25CF")
  end

  def play
    @board = Board.new
    player_1s_turn = true

    while !@board.four_in_a_row?  && !@board.is_board_full? do
      player = get_next_player(player_1s_turn)

      move = get_move(player)
      
      @board.drop_mark!(move, player.mark)

      puts @board.to_s

      player_1s_turn = !player_1s_turn
    end

    print_end_statement(player)

    play if play_again?
  end

  private

  def get_move(player)
    move = player.get_next_move

    unless @board.is_column_full?(move)
      return move
    else
      puts "That column is already full! Enter another."
      get_move(player)
    end
  end

  def get_next_player(player_1s_turn)
    if player_1s_turn
      player = @player2
    else 
      player = @player1
    end
  end

  def print_end_statement(player)
    if @board.four_in_a_row?
      puts "#{player.mark} Wins!"
    else
      puts "It's a draw!"
    end
  end

  def play_again?
    print "Would you like to play again? (yes/no) : "
    response = gets.chomp

    if response == "yes"
      return true
    elsif response == "no"
      return false
    else
      puts "Respond with yes or no."
      play_again?
    end
  end
end
