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
    complete_capture(piece, capture, destination) if capture.is_a?(Piece)
  end

  def complete_capture(piece, capture, destination)
    capture_errors(piece, capture)
    remove_piece(destination)
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
end