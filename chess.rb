class Game
  attr_reader :pieces
  
  def initialize(pieces)
    @pieces = pieces
  end
  
  def move(position, destination)

    moving_piece = pieces.find_at(position)

    error_catcher( moving_piece, destination)

    router(pieces.vacancy?(destination), moving_piece, destination)
  end

  def error_catcher(moving_piece, destination)
    !pieces.valid_coordinates?(destination) ? raise('Invalid destination') : true
    !moving_piece ? raise('No piece there!') : true
  end

  def router(dest_vacancy, moving_piece, destination)
    if dest_vacancy
      moving_piece.move?(destination)
    else
      moving_piece.capture?(destination)
    end
  end

  def test
    pieces.find_at('berkin')
  end
  
end

class Pieces
  attr_accessor :collection

  #Piece.new('type', ['A',1]), Piece.new('type', ['B',1])

  def initialize
    @collection = []
  end

  #def [](position)
  #
  #end

  def place(type, position)
    position = Coordinate.new(position)
    error_catcher(type, position)
    @collection.push([type, position])
    @collection.last()
  end

  def error_catcher(type, position)
    !valid_type?(type) ? raise('Invalid type') : true
    !valid_coordinates?(position) ? raise('Invalid position') : true
    find_at(position) ? raise('Position occupied') : true
  end

  def valid_type?(type)
    types = ['type', 'rook', 'pawn']
    types.include?(type)
  end

  def valid_coordinates?(coordinates)
    coordinates.x.between?('A', 'H') && coordinates.y.between?(1, 8)
  end
  
  def find_at(position)
    @collection.find {|piece| piece[1].eql?(position)}
  end
  
  def vacancy?(destination)
     truth = @collection.select do |piece|
       piece[1].eql?(destination)
    end
    truth.empty?
  end
end

class Piece
  attr_accessor :type, :position
  
  def initialize(type, position)
    @type = type
    @position = position
  end
  
  def capture?(dest)
    'capture'
  end
  
  def move?(dest)
    'move'
  end

  def legal_destination?(destination, allowed_moves)
    allowed_moves.include?(destination)
  end

end

class Rook
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def capture?(destination)
    move?(destination)
  end

  def move?(destination)
    'move'
  end

end

class RookRules

  def generate_moves(position)
     x = position[0]
     y = position[1]
     possible_moves = []
     letter = 'A'
    1.upto(8) do |i|
      possible_moves.push([x,i])
      possible_moves.push([letter,y])
      letter = letter.next
    end
     possible_moves = possible_moves.reject{ |allowed| allowed == position }
  end
end


#NEW STUFF

class Coordinate
  attr_accessor :x, :y

  def initialize(coordinates)
    coordinates = coordinates.split('')
    @x = coordinates[0]
    @y = coordinates[1].to_i
  end

  def eql?(arg)
    arg.x == @x && arg.y == @y
  end

end


class Move
  attr_accessor :position, :destination

  def initialize(position, destination)
    @position = Coordinate.new(position)
    @destination = Coordinate.new(destination)
  end

end

class MoveFactory

  def generate_move(move, type)
    type = titleize(type)+'Rules'
  end

  def titleize(string)
    new_string = string.slice(0,1).capitalize + string.slice(1..-1)
  end

end

