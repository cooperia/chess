class Piece
  attr_accessor :type, :color, :position

  def initialize(type, color, position)
    @type = type
    @color = color
    @position = Coordinate.new(position)
  end

  def set_position(new_position)
    self.position = new_position
  end

  def generate_allowed_path(move)
    path_factory = generate_path_factory
    path_factory.generate_path(move)
  end

  def generate_path_factory()
    Object.const_get(titleize(type) +'PathFactory').new
  end

  def titleize(string)
    string.slice(0,1).capitalize + string.slice(1..-1)
  end
end