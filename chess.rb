class Game
  def initialize
    @whiteArray = []
    @blackArray = []
    #fill arrays with pawns
    for i in 1..8
      @whiteArray.push(Pawn.new(i, [i,2], 'white'))
      @blackArray.push(Pawn.new(i, [i,7], 'black'))
    end
  end
  
  
  def whiteArray
    @whiteArray
  end
  
  
  def blackArray
    @blackArray
  end
  
  
  def getPieceById(id, color)
    if color == 'white'
      @whiteArray.each { |x|
        if x.id == id
          return x
        end
      }
    else
      @blackArray.each { |x|
        if x.id == id
          return x
        end
      }
    end
  end
  
  
  def movePiece(id, color, dest)
    #make sure dest is on the board
    if dest[0].between?(1,8) and dest[1].between?(1,8)
      piece = self.getPieceById(id, color)
      
      if color == 'white'
        #handle white moves
        if @whiteArray.any? {|x| x.position == dest}
          return 'Not Valid(friendly)'
        end
        return piece.move(dest, @blackArray, @whiteArray)
      else
        #handle black moves
        if @blackArray.any? {|x| x.position == dest}
          return 'Not Valid(friendly)'
        end
        return piece.move(dest, @whiteArray, @blackArray)
      end
    end
    
    #if not on the board, return 'Not Valid(overboard)'
    return 'Not Valid(overboard)'
  end
end

class Piece
  attr_accessor :position
  attr_accessor :color
  attr_accessor :id
  
  
  #initialize variables that will be relevant for all pieces
  def initialize(id, start, color)
    self.position = start
    self.color = color
    self.id = id
  end
end

#Pawn Class
class Pawn < Piece
  def type
    @type = 'pawn'
  end
  
  
  #check possible moves, ignores captures. Only Relevant to pawns.
  def checkMove (dest, opArray, frArray)
    #check to make sure there aren't any pieces at the destination
    if frArray.any?{|x| x.position == dest} or opArray.any?{ |x| x.position == dest}
      return false
    end
    
    #handle white
    if self.color == 'white'
      if self.position[1] != 2
        #everywhere other than start
        @move_array = [[self.position[0], self.position[1]+1]]
        @move_array = @move_array.reject { |x| x[1] > 8 or x[1] < 2 }
      else
        #start position moveArray
        #make sure there are no obstructions, if there are, don't bother
        if frArray.any?{|x| x.position == [self.position[0], 3]} or opArray.any?{|x| x.position == [self.position[0], 3]}
          return false
        end
        @move_array = [[self.position[0], self.position[1]+1], [self.position[0], self.position[1]+2]]
        
      end
     
    #handle black  
    else
      if self.position[1] != 7
        #everywhere other than start
        @move_array = [[self.position[0], self.position[1]-1]]
        @move_array = @move_array.reject { |x| x[1] > 7 or x[1] < 1 }
      else
        #start position moveArray
        #make sure there are no obstructions, if there are, don't bother
        if frArray.any?{|x| x.position == [self.position[0], 6]} or opArray.any?{|x| x.position == [self.position[0], 6]}
          return false
        end
        @move_array = [[self.position[0], self.position[1]-1], [self.position[0], self.position[1]-2]]
      end
    end
    if @move_array.include? dest
      
      return true
    end
    return false
  end
  
  
  def checkCapture (dest, opArray)
    #Make sure this is a valid capture
    if self.color == 'white'
      if dest[1] != self.position[1]+1
        return false
      end
    else 
      if dest[1] != self.position[1]-1
        return false
      end
    end
    #make sure there is an opposing piece at destination
    opArray.each { |x|
      if x.position == dest
          opArray.delete(x)
        return true
      end
    }
    return false
  end
  
  
  def move(dest, opArray, frArray)
    #determine which check to run
    if self.position[0] == dest[0]
      if self.checkMove(dest, opArray, frArray)
        self.position = dest
        return 'Moved!'
      else 
        return 'Not Valid'
      end
    else
      if self.checkCapture(dest, opArray)
        self.position = dest
        return 'Capture!'
      else
        return 'Not Valid'
      end
    end 
  end


  def listArray
    @move_array 
  end
end