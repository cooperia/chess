class RookPathFactory

  def generate_path(move)
    moves = generate_moves(move.position)
    raise('Invalid move for a rook') unless valid_move?(moves, move.destination)
    a_ranged = move.arranger
    path_array(a_ranged, move.position)
  end

  def path_array(a_ranged, position)
    path_array = []
    (a_ranged.first.next...a_ranged.last).each do |entry|
      path_array.push(Coordinate.new(entry))
    end
    if path_array.length > 6
      path_array = path_array.reject { |entry| !entry.legal? || position.y != entry.y }
    end
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

  #module candidate
  def valid_move?(valid_moves, destination)
    valid_moves.any? { |move| move.equal?(destination)}
  end
end
