class Move
  attr_accessor :position, :destination

  def initialize(position, destination)
    raise error unless valid?(position, destination)
    @position = Coordinate.new(position)
    @destination = Coordinate.new(destination)
  end

  def valid?(position, destination)
    position != destination
  end

  def error
    raise 'Position must be different from destination'
  end

  def equal?(move_object)
    move_object.position.equal?(position) && move_object.destination.equal?(destination)
  end

   #?
   def move(pieces)
     piece = pieces.get_moving_piece(self)
     path = piece.generate_allowed_path(self)
     pieces.complete_move(piece, path, self)
     #Are we passing way too much? Or should we continue asking pieces
     #questions until we know exactly what is going on.
   end

  def arranger
    [position.stringify, destination.stringify].sort
  end

  def get_direction
    position.x == destination.x ? 'vertical' : 'horizontal'
  end



  #
  #
  ##def move(move)
  ##  capture = verify_move(move)
  ##  prepare_move(move)
  ##  perform_move(move, capture)
  ##end
  #
  #def verify_move(move)
  #  vacancy?(move.destination) ? nil : capture_error_catcher(move)
  #end
  #
  #def prepare_move(move)
  #  piece = find_at(move.position)
  #  required_path = @move_factory.generate_move(move, piece[0].type)
  #  path_check?(required_path)
  #end
  #
  #def perform_move(move, capture = nil)
  #  destroy_piece(move.destination) if capture
  #  piece = find_at(move.position)
  #  update_position(piece, move.destination)
  #end
  #
  #def update_position(piece, move_destination)
  #  piece[1] = move_destination
  #end
  #
  #def move_error_catcher(move)
  #  #use this pattern
  #  raise('No piece at position') unless find_at(move.position)
  #end
  #
  #def capture_error_catcher(move)
  #  captured_piece = find_at(move.destination)[0]
  #  piece = find_at(move.position)[0]
  #  raise(RuntimeError, 'Can\'t capture your own pieces!') if captured_piece.color == piece.color
  #end
end
