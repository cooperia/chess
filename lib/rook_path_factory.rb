class RookPathFactory

  #TODO: Modularify the array generation process
  #Direction x, Direction y (in move object)
  def generate_path(move)
    moves = generate_moves(move.position)
    raise('Invalid move for a rook') unless valid_move?(moves, move.destination)
    a_ranged = move.arranger
    direction = move.get_direction
    send("#{direction}_path_array", a_ranged, move.position)
  end

  def vertical_path_array(a_ranged, position)
    path_array = []
    (a_ranged.first.next...a_ranged.last).each do |entry|
      path_array.push(Coordinate.new(entry))
    end
    path_array
  end

  def horizontal_path_array(a_ranged, position)
    path_array = []
    range = (a_ranged.first.slice(0,1).next...a_ranged.last.slice(0,1))
    range.each { |entry| path_array.push(Coordinate.new(entry + position.y.to_s)) }
    path_array
  end

  def generate_moves(position)
    possible_moves = []
    letter = 'A'
    1.upto(8) do |i|
      possible_moves.push(Coordinate.new(position.x.to_s+i.to_s))
      possible_moves.push(Coordinate.new(letter+position.y.to_s))
      letter = letter.next
    end
    possible_moves = possible_moves.reject{ |allowed| allowed.equal?(position) }
  end

  def valid_move?(valid_moves, destination)
    valid_moves.find { |move| move.equal?(destination)} ? true : false
  end
end
