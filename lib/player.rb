class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def get_next_move
    print "#{mark}, enter the column you want to drop your mark (1..7): "
    move = gets.chomp

    if (1..7).include?(move.to_i)
      return move.to_i - 1
    else
      puts "Enter a valid column"
      get_next_move
    end
  end
end
