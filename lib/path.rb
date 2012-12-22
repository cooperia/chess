class Path
  attr_accessor :requirements

  def initialize
    @requirements = []
  end

  def add(location)
    requirements.push(location)
  end

  def obstructed?(board)
    requirements.each do |requirement|
      raise('Path obstructed') if board.any? {|piece| piece.position.equal?(requirement)}
    end
  end

  def included?(position)
    requirements.any? {|requirement| position.equal?(requirement) }
  end

  def size
    requirements.length
  end

  #This is possibly problematic. Currently knight doesn't use this method.
  def clean(position)
    self.requirements = requirements.reject { |entry| !entry.legal? || position.y != entry.y }
  end
end