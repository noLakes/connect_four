
class Game
  attr_reader :board

  def initialize(board = build_board)
    @board = board
  end
  
  def build_board
    board = {}
    6.times do |row|
      7.times do |cell|
        board[[row + 1, cell + 1]] = nil
      end
    end
    board
  end

  def txt
    output = []
    @board.each_pair do |key, val| 
      val.nil? ? output << '[  ]' : output << val
      output << "\n" if key[1] == 7
    end
    output.join()
  end

end