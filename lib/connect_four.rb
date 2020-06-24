
class Game
  
  def build_board
    board = {}
    6.times do |row|
      7.times do |cell|
        board[[row + 1, cell + 1]] = nil
      end
    end
    board
  end

end