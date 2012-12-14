class Game
  attr_reader :pieces
  
  def initialize(pieces)
    @pieces = pieces
  end
  
  def move(position, destination)

    moving_piece = pieces.find_at(position)
    dest_vacancy = pieces.vacancy?(destination)

    error_catcher(moving_piece, destination)

    if dest_vacancy
      moving_piece.move?(destination)
    else
      moving_piece.capture?(destination)
    end
  end

  def error_catcher(moving_piece, destination)
    !pieces.valid_coordinates?(destination) ? raise('Invalid destination') : true
    !moving_piece ? raise('No piece there!') : true
  end
  
end

class Pieces
  attr_accessor :collection

  def initialize
    @collection = [Piece.new('type', ['A',1]), Piece.new('type', ['B',1])]
  end

  #def [](position)
  #
  #end

  def place(type, position)
    error_catcher(type, position)
    @collection.push(Piece.new(type, position))
    @collection.last()
  end

  #-TODO:Check if position occupied
  def error_catcher(type, position)
    !valid_type?(type) ? raise('Invalid type') : true
    !valid_coordinates?(position) ? raise('Invalid position') : true
    find_at(position) ? raise('Position occupied') : true
  end

  def valid_type?(type)
    types = ['type', 'rook']
    types.include?(type)
  end

  def valid_coordinates?(coordinates)
    coordinates[0].between?('A', 'H') && coordinates[1].between?(1, 8)
  end
  
  def find_at(position)
    @collection.find {|piece| piece.position == position}
  end
  
  def vacancy?(destination)
     truth = @collection.select do |piece|
       piece.position == destination 
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

class Coordinates
  attr_accessor :x, :y

  def initialize(coordinates)
    @x = coordinates[0]
    @y = coordinates[1]
  end

end


class Move
  attr_accessor :position, :destination

  def initialize(position, destination)
    @position = Coordinates.new(position)
    @destination = Coordinates.new(destination)
  end

end

