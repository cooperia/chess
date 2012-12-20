class RookPathGenerator
  def self.generate(move)
    a_ranged = self.arranger(move)
    path = Path.new
    (a_ranged.first.next...a_ranged.last).each do |entry|
      path.add(Coordinate.new(entry))
    end
    self.cleaner(path, move.origin) if self.horizontal?(path)
    path
  end

  def self.horizontal?(path)
    path.size > 6
  end

  def self.cleaner(path, origin)
    path.clean(origin)
  end

  def self.arranger(move)
    [move.origin.stringify, move.destination.stringify].sort
  end
end
