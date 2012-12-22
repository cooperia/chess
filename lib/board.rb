class Board
  attr_accessor :collection

  def initialize
    @collection = []
  end

  def find_at(position)
    collection.find {|piece| piece.position.equal?(position)}
  end

  def capture_at(destination, piece)
    capture = find_at(destination)
    capture_errors(piece, capture) if capture.is_a?(Piece)
    remove_piece(destination) if capture.is_a?(Piece)
  end

  def capture_errors(piece, capture)
    raise('Can\'t capture your own pieces!') if piece.color == capture.color
  end

  def remove_piece(destination)
    self.collection = collection.reject { |piece| piece.position.equal?(destination) }
  end

  def place(type, color, position)
    place_error_catcher(Coordinate.new(position))
    collection.push(Piece.new(type, color, position)).last()
  end

  def place_error_catcher(position)
    raise('Position occupied') if find_at(position)
  end












  #
  #
  #
  #
  #
  #def get_moving_piece(move)
  #  raise('No piece at position') unless find_at(move.position)
  #  find_at(move.position)
  #end
  #
  #def complete_move(piece, path, move)
  #  obstructed?(path)
  #  move_type = check_move_type(move)
  #  send("complete_#{move_type}_move", piece, move)
  #end
  #
  #def check_move_type(move)
  #  vacancy?(move.destination) ? 'regular' : 'capture'
  #end
  #
  #def complete_regular_move(piece, move)
  #  update_position(piece, move.destination)
  #  true
  #end
  #
  #def complete_capture_move(piece, move)
  #  capture_error_catcher(move)
  #  destroy_piece(move.destination)
  #  complete_regular_move(piece, move)
  #end
  #
  #
  #
  #def verify_move(move)
  #  vacancy?(move.destination) ? nil : capture_error_catcher(move)
  #end
  #
  #
  #
  #def update_position(piece, move_destination)
  #  piece.set_position(move_destination)
  #end
  #
  #
  #
  ##TODO:Possibly move all errors into an error class and pass self and state
  #
  #
  #
  #
  #def vacancy?(destination)
  #  !collection.any? { |piece| piece.position.equal?(destination) }
  #end
end