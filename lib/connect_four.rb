
class Game
  attr_reader :board, :players, :turn, :DIAGONALS

  DIAGONALS = [
    [[3, 1], [4, 2], [5, 3], [6, 4]],
    [[2, 1], [3, 2], [4, 3], [5, 4], [6, 5]],
    [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]],
    [[1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [6, 7]],
    [[1, 3], [2, 4], [3, 5], [4, 6], [5, 7]],
    [[1, 4], [2, 5], [3, 6], [4, 7]],
    [[1, 4], [2, 3], [3, 2], [4, 1]],
    [[1, 5], [2, 4], [3, 3], [4, 2], [5, 1]],
    [[1, 6], [2, 5], [3, 4], [4, 3], [5, 2], [6, 1]],
    [[1, 7], [2, 6], [3, 5], [4, 4], [5, 3], [6, 2]],
    [[2, 7], [3, 6], [4, 5], [5, 4], [6, 3]],
    [[3, 7], [4, 6], [5, 5], [6, 4]]
  ]

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
        val.nil? ? out << '[ ]' : out << "[#{val}]"
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
    @board[read] = "#{@players[@turn]}"
  end

  #just for easier testing
  def multi_move(*args)
    args.each do |col|
      place_token(col) unless column_full?(col)
      switch_turn
    end
  end

  def column_full?(column) 
    !@board[[6, column]].nil?
  end

  def get_move
    puts "Enter a number for column 1-7:"
    loop do
      input = gets.chomp.to_i
      return input if input.between?(1, 7) && !column_full?(input)
      if !input.between(1, 7)
        puts "Invalid. Enter a number between 1-7"
      else
        puts "That column is full, try again!"
      end
    end
  end

  def switch_turn
    @turn == 1 ? @turn = 2 : @turn = 1
  end

  def check_win
    test = [get_rows, get_columns, get_diagonals].flatten(1)
    result = nil
    test.each do |array|
      result = check_four(array)
      break if !result.nil?
    end
    result
  end

  def check_four(arry)
    return nil if arry.length < 4
    count = []
    
    arry.each do |val|
      if count.length.zero? || count[-1] == val
        count << val
      else
        count = []
        count << val
      end
      break if count.length >= 4
    end
    count.length >= 4 ? count[0] : nil
  end

  def get_rows
    rows = []
    6.times do |row|
      container = []
      7.times do |col|
        container << @board[[row+1, col+1]]
      end
      rows << container unless container.all?(nil)
    end
    rows
  end

  def get_columns
    columns = []
    7.times do |col|
      container = []
      6.times do |row|
        container << @board[[row+1, col+1]]
      end
      columns << container unless container.all?(nil)
    end
    columns
  end 

  def get_diagonals
    result = []
    DIAGONALS.each do |arry|
      diagonal = arry.map { |val| @board[val] }
      result << diagonal unless diagonal.all?(nil)
    end
    result
  end

end
