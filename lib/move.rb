class Move
  attr_accessor :position, :destination

  def initialize(position, destination)
    raise error unless valid?(position, destination)
    @position = Coordinate.new(position)
    @destination = Coordinate.new(destination)
    raise 'Invalid Coordinates' unless self.legal?
  end

  #?
  def move(pieces)
    piece = pieces.get_moving_piece(self)
    path = piece.generate_allowed_path(self)
    pieces.complete_move(piece, path, self)
    #Are we passing way too much? Or should we continue asking pieces
    #questions until we know exactly what is going on.
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

  def legal?
    @position.legal? && @destination.legal?
  end

  def arranger
    [position.stringify, destination.stringify].sort
  end
end
