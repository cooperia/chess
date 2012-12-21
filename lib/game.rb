class Game
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def move(origin, destination)
    Move.new(origin, destination, board).perform
  end
end