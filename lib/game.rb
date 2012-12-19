class Game
  attr_reader :pieces

  def initialize(pieces)
    @pieces = pieces
  end

  def move(position, destination)
    Move.new(position, destination).move(pieces)
  end
end