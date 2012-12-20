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

  def generate_move
    Object.const_get(titleize(type) +'MoveGenerator').generate(position)
  end

  def generate_path(move)
    Object.const_get(titleize(type) + 'PathGenerator').generate(move)
  end

  def titleize(string)
    string.slice(0,1).capitalize + string.slice(1..-1)
  end
end