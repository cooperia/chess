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
    !valid_destination?(destination) ? raise('Invalid destination') : true
    !moving_piece ? raise('No piece there!') : true
  end

  
  def valid_destination?(destination)    
    destination[0].between?('A', 'H') && destination[1].between?(1, 8)
  end
  
end

class Pieces
  attr_accessor :collection

  def initialize
    @collection = [Piece.new(['A',1]), Piece.new(['B',1])]
  end

  #def [](position)
  #
  #end
  
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
  attr_accessor :position
  
  def initialize(position)
    @position = position
  end
  
  def capture?(dest)
    'capture'
  end
  
  def move?(dest)
    'move'
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

  def check_destination_allowed?(destination, allowed_moves)
    allowed_moves.include?(destination)
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
