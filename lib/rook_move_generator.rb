class RookMoveGenerator
  def self.generate(origin)
    possible_moves = PossibleMoves.new
    letter = 'A'
    1.upto(8) do |i|
      possible_moves.add(Coordinate.new(origin.x + i.to_s))
      possible_moves.add(Coordinate.new(letter + origin.y.to_s))
      letter = letter.next
    end
    possible_moves.reject(origin)
    possible_moves
  end
end
