class Coordinate
  MIN_ROW = 1
  MAX_ROW = 8
  MIN_COL = 'A'
  MAX_COL = 'H'

  attr_accessor :x, :y

  def initialize(coordinates)
    coordinates = coordinates.split('')
    @x = coordinates[0]
    @y = coordinates[1].to_i
    raise('Invalid Coordinates') unless self.legal?
  end

  def legal?
    x.between?(MIN_COL, MAX_COL) && y.between?(MIN_ROW, MAX_ROW)
  end

  def equal?(arg)
    arg.x == x && arg.y == y
  end

  def stringify
    x.to_s + y.to_s
  end
end