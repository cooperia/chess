class Game
  attr_reader :pieces
  
  def initialize(pieces)
    @pieces = pieces
  end
  
  def move_piece(args)
    destination = args[:destination]
    current_position = args[:current_position]
    
    moving_piece = pieces.find_piece_by_position(current_position)
    dest_vacancy = pieces.check_destination_vacancy?(destination)
    
    if dest_vacancy
      moving_piece.move?
    else
      moving_piece.capture?
    end
  end
  
  

end

class Pieces
  attr_accessor :collection
  
  def initialize
    @collection = [Piece.new(['A',1])]
  end
  
  def find_piece_by_position(current_position)
    
  end
  
  def check_destination_vacancy?(destination)
    destination
  end
end

class Piece
  attr_accessor :position
  
  def initialize(position)
    @position = position
  end
  
  def capture?(dest)
    false
  end
  
  def move?(dest)
    true
  end
  
end
