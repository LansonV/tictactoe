PLACEHOLDER = '#'

class Board
  def initialize()
    @board = %w(
      ┌───┐
      │···│
      │···│
      │···│
      └───┘
    )
  end

  def show()
    puts @board
  end

  def make_move(player, field)
    x = field % 10
    y = field.div(10)
    @board[x][y] = player.sign
  end

  def result
    # Define winning patterns (rows, columns, and diagonals)
    winning_patterns = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9], # Rows
      [1, 4, 7], [2, 5, 8], [3, 6, 9], # Columns
      [1, 5, 9], [3, 5, 7]              # Diagonals
    ]
    # 1. check for win
    board = PLACEHOLDER + @board[1..3].map {|line| line[1..3]}.join # '#XO.X.OXOX'
    # Iterate through winning patterns and check if any player wins

    winning_patterns.each do |pattern|
      markers = pattern.map { |position| board[position] }
      return 'Player X wins!' if markers.all? { |marker| marker == 'X' }
      return 'Player O wins!' if markers.all? { |marker| marker == 'O' }
    end

    # 2. check for emty cells
    return "Playing..." if @board.join.include?('·')

    # 3. Draft
    return "Draft"
  end

  def continue?
    result.include?('...') ? true : false
  end
end

class Player
  attr_accessor :sign

  def initialize(sign)
    @sign = sign
  end
end

players = [Player.new('X'), Player.new('O')]
game = Board.new
game.show

while game.continue? do
  # 1. prompt for input
  print "Player #{players.first.sign}, please make your move (11..33): "
  move = gets.chomp.to_i

  # 2. make move
  game.make_move(players.first, move)

  # 3. rotate players
  players.rotate!

  # 4. game.show
  game.show
end

pp game.result