class Move
  attr_accessor :origin, :destination, :piece, :board

  def initialize(origin, destination, board)
    @origin = Coordinate.new(origin)
    @board = board
    @destination = Coordinate.new(destination)
    @piece = board.find_at(origin)
    errors
  end

  def perform
    verify_move
    complete(piece) if verify_path?
  end

  def verify_path?
    path = piece.generate_path(self)
    path.obstructed?(board)
  end

  def verify_move
    possible_moves = piece.generate_move
    possible_moves.includes?(destination)
  end

  def complete(piece)
    board.capture_at(destination)
    piece.set_position(destination)
  end

  def valid?
    !origin.equal?(destination)
  end

  def errors
    raise_unless_coordinates_are_legal unless legal?
    raise_if_origin_equals_destination unless valid?
  end

  def raise_unless_coordinates_are_legal
    raise 'Invalid Coordinates'
  end

  def raise_if_origin_equals_destination
    raise 'Position must be different from destination'
  end

  def equal?(move_object)
    move_object.origin.equal?(origin) && move_object.destination.equal?(destination)
  end

  def legal?
    origin.legal? && destination.legal?
  end
end
