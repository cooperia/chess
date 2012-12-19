class Coordinate
  MIN_ROW = 1
  MAX_ROW = 8
  MIN_COL = 'A'
  MAX_COL = 'H'
  LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

  attr_accessor :x, :y

  def initialize(coordinates)
    coordinates = coordinates.split('')
    @x = coordinates[0]
    @y = coordinates[1].to_i
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

  def delta_x(unit)
    delta = LETTERS.index(x) + unit
    if delta >= 0
      LETTERS[delta]
    else
      'Z'
    end
  end
end