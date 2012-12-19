class KnightPathFactory
  def generate_path(move)
    moves = generate_moves(move.position)
    raise('Invalid move for a knight') unless valid_move?(moves, move.destination)
    []
  end

  def generate_moves(position)
    possible_moves = []
    possible_moves.push(Coordinate.new(position.delta_x(-1) + (position.y+2).to_s))
    possible_moves.push(Coordinate.new(position.delta_x(-1) + (position.y-2).to_s))
    possible_moves.push(Coordinate.new(position.delta_x(-2) + (position.y+1).to_s))
    possible_moves.push(Coordinate.new(position.delta_x(-2) + (position.y-1).to_s))
    possible_moves.push(Coordinate.new(position.delta_x(+1) + (position.y+2).to_s))
    possible_moves.push(Coordinate.new(position.delta_x(+1) + (position.y-2).to_s))
    possible_moves.push(Coordinate.new(position.delta_x(+2) + (position.y+1).to_s))
    possible_moves.push(Coordinate.new(position.delta_x(+2) + (position.y-1).to_s))

    possible_moves = possible_moves.reject {|entry| !entry.legal? }
  end

  #module candidate
  def valid_move?(valid_moves, destination)
    valid_moves.any? { |move| move.equal?(destination)}
  end
end

