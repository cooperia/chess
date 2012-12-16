class Game
  attr_reader :pieces
  
  def initialize(pieces)
    @pieces = pieces
  end
  
  def move(position, destination)
    new_move = moveifier(position, destination)
    pieces.move(new_move)

    #moving_piece = pieces.find_at(position)
    #
    #error_catcher( moving_piece, destination)
    #
    #router(pieces.vacancy?(destination), moving_piece, destination)
  end

  def moveifier(position, destination)
    Move.new(position, destination)
  end

  #def error_catcher(moving_piece, destination)
  #  !pieces.valid_coordinates?(destination) ? raise('Invalid destination') : true
  #  !moving_piece ? raise('No piece there!') : true
  #end
  #
  #def router(dest_vacancy, moving_piece, destination)
  #  if dest_vacancy
  #    moving_piece.move?(destination)
  #  else
  #    moving_piece.capture?(destination)
  #  end
  #end
  #
  #def test
  #  pieces.find_at('berkin')
  #end
  
end

class Pieces
  attr_accessor :collection

  def initialize
    @collection = []
    @move_factory = MoveFactory.new
  end

  def move(move)
    move_error_catcher(move)
    vacancy?(move.destination) ? true : 'capture'
    piece = find_at(move.position)
    @move_factory.generate_move(move, piece[0].type)

  end

  def path_check?(path)
    path.each do |position|
       vacancy?(position) ? true : raise('Path obstructed')
    end
    true
  end

  def place(type, color, position)
    position = Coordinate.new(position)
    place_error_catcher(position)
    @collection.push([Piece.new(type, color), position])
    @collection.last()
  end

  def place_error_catcher(position)
    !valid_coordinates?(position) ? raise('Invalid Position') : true
    #!valid_coordinates?(move.destination) ? raise('Invalid Destination') : true
    find_at(position) ? raise('Position occupied') : true
  end

  def move_error_catcher(move)
    !find_at(move.position) ? raise('No piece at position') : true
    !valid_coordinates?(move.destination) ? raise('Invalid Destination') : true
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
  attr_reader :type, :color
  
  def initialize(type, color)
    error_catcher(type, color)
    @type = type
    @color = color
  end

  def error_catcher(type, color)
    !valid_type?(type) ? raise('Invalid type') : true
    !valid_color?(color) ? raise('Invalid color') : true
  end

  private

  def valid_color?(color)
    colors = ['black', 'white']
    colors.include?(color)
  end

  def valid_type?(type)
    types = ['type', 'rook', 'pawn']
    types.include?(type)
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

  def generate_path(move)
    moves = generate_moves(move.position)
    if valid_move?(moves, move.destination)

    else
      raise('Invalid move for a rook')
    end
  end


  def generate_moves(position)
     possible_moves = []
     letter = 'A'
    1.upto(8) do |i|
      possible_moves.push(Coordinate.new(position.x.to_s+i.to_s))
      possible_moves.push(Coordinate.new(letter+position.y.to_s))
      letter = letter.next
    end
     possible_moves = possible_moves.reject{ |allowed| allowed.eql?(position) }
  end

  def valid_move?(valid_moves, destination)
    valid_moves.find { |move| move.eql?(destination)} ? true : false
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

  def eql?(other)
    other.position.eql?(@position) &&  other.destination.eql?(@destination)
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

