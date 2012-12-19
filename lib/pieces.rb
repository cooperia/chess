class Pieces
  attr_accessor :collection

  def initialize
    @collection = []
  end

  def get_moving_piece(move)
    raise('No piece at position') unless find_at(move.position)
    find_at(move.position)
  end

  def complete_move(piece, path, move)
    path_check?(path)
    move_type = check_move_type(move)
    send("complete_#{move_type}_move", piece, move)
  end

  def check_move_type(move)
    vacancy?(move.destination) ? 'regular' : 'capture'
  end

  def complete_regular_move(piece, move)
    update_position(piece, move.destination)
    true
  end

  def complete_capture_move(piece, move)
    capture_error_catcher(move)
    destroy_piece(move.destination)
    complete_regular_move(piece, move)
  end

  def destroy_piece(destination)
    self.collection = collection.reject { |piece| piece.position.equal?(destination) }
  end

  def path_check?(path)
    path.each do |position|
      raise('Path obstructed') unless vacancy?(position)
    end
    true
  end

  def verify_move(move)
    vacancy?(move.destination) ? nil : capture_error_catcher(move)
  end

  def prepare_move(move)
    piece = find_at(move.position)
    required_path = @move_factory.generate_move(move, piece[0].type)
    path_check?(required_path)
  end

  def place(type, color, position)
    place_error_catcher(Coordinate.new(position))
    collection.push(Piece.new(type, color, position)).last()
  end

  def update_position(piece, move_destination)
    piece.set_position(move_destination)
  end

  def find_at(position)
    collection.find {|piece| piece.position.equal?(position)}
  end

  #TODO:Possibly move all errors into an error class and pass self and state
  def place_error_catcher(position)
    raise('Position occupied') if find_at(position)
  end

  def capture_error_catcher(move)
    captured_piece = find_at(move.destination)
    piece = find_at(move.position)
    raise(RuntimeError, 'Can\'t capture your own pieces!') if captured_piece.color == piece.color
    'capture'
  end

  def vacancy?(destination)
    !collection.any? { |piece| piece.position.equal?(destination) }
  end
end