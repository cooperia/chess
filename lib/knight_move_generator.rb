class KnightMoveGenerator

  def self.generate(position)
    possible_moves = PossibleMoves.new
    move_deltas = [[-1, 2], [-1, -2], [-2, 1], [-2, -1], [1, 2], [1, -2], [2, 1], [2, -1]]

    move_deltas.each do |delta|
      possible_moves.add(Coordinate.new(position.delta_x(delta[0]) + (position.y + delta[1]).to_s))
    end
    possible_moves.clean
    possible_moves
  end
end

