class RookPathGenerator
  attr_accessor :move, :path

  def initialize(move)
     @move = move
     @path = Path.new
  end

  def self.generate(move)
    generator = RookPathGenerator.new(move)
    a_ranged = generator.arranger
    (a_ranged.first.next...a_ranged.last).each do |entry|
      generator.path.add(Coordinate.new(entry))
    end
    generator.cleaner(position) if generator.horizontal?
    generator.path
  end

  def horizontal?
    path.size > 6
  end

  def cleaner
    self.path = path.clean(move.origin)
  end

  def arranger
    [move.origin.stringify, move.destination.stringify].sort
  end
end
