class KnightPathFactory

  def generate_path(move)
    moves = generate_moves(move.position)
    raise('Invalid move for a knight') unless valid_move?(moves, move.destination)
    []
  end

  def generate_moves(position)
    possible_moves = []
    move_deltas = [[-1, 2], [-1, -2], [-2, 1], [-2, -1], [1, 2], [1, -2], [2, 1], [2, -1]]

    move_deltas.each do |delta|
      possible_moves.push(Coordinate.new(position.delta_x(delta[0]) + (position.y + delta[1]).to_s))
    end
    possible_moves = possible_moves.reject {|entry| !entry.legal? }
  end

  #module candidate
  def valid_move?(valid_moves, destination)
    valid_moves.any? { |move| move.equal?(destination)}
  end
end

