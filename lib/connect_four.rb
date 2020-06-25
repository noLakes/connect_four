
class Game
  attr_reader :board, :players, :turn

  def initialize(player_1 = 'O', player_2 = 'X')
    @board = build_board
    @players = {1 => player_1, 2 => player_2}
    @turn = 1
  end
  
  def build_board
    board = {}
    6.times do |row|
      7.times do |col|
        board[[row + 1, col + 1]] = nil
      end
    end
    board
  end

  def txt(out = [], row = 6)
    until row == 0 do
      7.times do |col|
        val = @board[[row, col + 1]]
        val.nil? ? out << '[ ]' : out << val
      end
      out << "\n"
      row -= 1
    end
    (out << " 1  2  3  4  5  6  7\n").join()
  end

  def place_token(column) 
    read = [1, column]
    while !@board[read].nil? do
      read[0] += 1
    end
    @board[read] = "[#{@players[@turn]}]"
  end

end
