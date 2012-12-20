class RookMove
  attr_reader :move_options

  def initialize
    @move_options = []
  end

  def add(coordinate)
   move_options.push(coordinate)
  end

  def includes?(destination)
    raise('Invalid move for a rook') unless valid_move?(destination)
  end

  def valid_move?(destination)
    move_options.any? { |move| move.equal?(destination)}
  end

  def reject(arg)
    @move_options = move_options.reject { |option| option.equal?(arg) }
  end
end