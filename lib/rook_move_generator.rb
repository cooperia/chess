class RookMoveGenerator
  attr_accessor :origin

  def initialize(origin)
    @origin = origin
  end

  def self.generate(origin)
    generator = RookMoveGenerator.new(origin)
    possible_moves = RookMove.new
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
