#Game
class Game
  attr_reader :pieces
  
  def initialize
    @pieces = []
    for i in 1..8
      @pieces.push(Pawn.new(:position => [i,2], :color => 'white'))
      @pieces.push(Pawn.new(:position => [i,7], :color => 'black'))
    end
  end
  
  def move_piece(position, dest)
    piece = pieces.select { |x| x.position == position}
    piece[0].move(dest, pieces)
  end
end

#Piece
class Piece
  attr_reader :position, :color, :start
  
  def initialize(args)
    @position = args[:position]
    @color = args[:color]
    @start = true
  end
  
  def check_position_vacancy?(dest, pieces)
    !pieces.any? { |x| x.position == dest} 
  end
  
  def check_occupant_color(dest, pieces)
    piece = pieces.select { |x| x.position == dest}
    piece[0].color
  end
  
  def check_move_validity?(dest)
    if (1..8).include?(dest[0]) && (1..8).include?(dest[1]) 
      true
    else
      false
    end
  end
end

#Pawn
class Pawn < Piece
  
  def check_double_move?(pieces)
    if check_position_vacancy?([position[0], 3], pieces) && check_position_vacancy?([position[0], 4], pieces)
      true
    else
      false
    end
  end  
  
  def check_move_legality?(dest, pieces)
    if start && dest[1] == 4
      check_double_move?(pieces) 
    elsif dest[1] == position[1]+1
      check_position_vacancy?(dest, pieces)
    else
      false
    end
  end
  
  def check_capture_legality?(dest)
    if dest == [position[0]+1, position[1]+1] || dest == [position[0]+1, position[1]-1]
      true
    else
      false
    end
  end
  
  def check_capture?(dest, pieces)
    if check_capture_legality?(dest) && !check_position_vacancy?(dest, pieces) && check_occupant_color(dest, pieces) != color
      true
    else
      false
    end
  end
  
  def move(dest, pieces)
    if check_move_validity?(dest)
      if dest[0] != position[0]
        if check_capture?(dest, pieces)
          pieces.delete_if { |x| x.position == dest }
          start = false
          position = dest
        else
          "Illegal Capture"
        end
      elsif check_move_legality?(dest, pieces)
        start = false
        position = dest
      else
        "Illegal Move"
      end
    else
      "Invalid Destination"
    end
  end
end