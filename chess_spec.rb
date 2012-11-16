require 'chess'


describe Piece do
  describe '#new' do
    it "Accepts 3 params: id, start position, and color. Returns Piece object" do
      piece = Piece.new(2, [1,2], 'white')
      piece.id.should eq(2)
      piece.position.should eq([1,2])
      piece.color.should eq('white')
    end
  end
end


describe Pawn do
  describe '#new' do
    it "Accepts 3 params: id, start positon, and color. Returns a Pawn object" do
      pawn = Pawn.new(1, [1,2], 'white')
      pawn.id.should eq(1)
      pawn.position.should eq([1,2])
      pawn.color.should eq('white')
      pawn.type.should eq('pawn')
    end
  end
  
  describe '#checkMove - white' do
    it "Accepts 3 params: destination coord as array, friendly array, and opposing array. Returns true or false based on validity" do
      pawn = Pawn.new(1, [1,2], 'white')
      pawn2 = Pawn.new(2, [2,2], 'white')
      pawn3 = Pawn.new(3, [3,2], 'white')
      opArray = [Pawn.new(4, [2, 3], 'black')]
      frArray = [Pawn.new(5, [3, 3], 'white')]
      pawn.checkMove([1,3], opArray, frArray).should eq(true)
      pawn.checkMove([1,4], opArray, frArray).should eq(true)
      pawn.checkMove([1,5], opArray, frArray).should eq(false)
      pawn.checkMove([0,3], opArray, frArray).should eq(false)
      pawn2.checkMove([2,3], opArray, frArray).should eq(false)
      pawn2.checkMove([2,4], opArray, frArray).should eq(false)
      pawn3.checkMove([3,3], opArray, frArray).should eq(false)
      pawn3.checkMove([3,4], opArray, frArray).should eq(false)
    end
  end
  
  describe '#checkMove - black' do
    it "Accepts 3 params: destination coord as an array, friendly array, and opposing array. Returns true or false based on validity" do
      pawn = Pawn.new(1, [1,7], 'black')
      pawn2 = Pawn.new(2, [2,7], 'black')
      pawn3 = Pawn.new(3, [3,7], 'black')
      opArray = [Pawn.new(4, [2, 6], 'white')]
      frArray = [Pawn.new(5, [3, 6], 'black')]
      pawn.checkMove([1,6], opArray, frArray).should eq(true)
      pawn.checkMove([1,5], opArray, frArray).should eq(true)
      pawn.checkMove([1,4], opArray, frArray).should eq(false)
      pawn.checkMove([0,6], opArray, frArray).should eq(false)
      pawn2.checkMove([2,6], opArray, frArray).should eq(false)
      pawn2.checkMove([2,5], opArray, frArray).should eq(false)
      pawn3.checkMove([3,6], opArray, frArray).should eq(false)
      pawn3.checkMove([3,5], opArray, frArray).should eq(false)
    end
  end
  
  describe '#checkCapture - white' do 
    it "Accepts 2 params: destination coords as an array and opposing array. Returns true or false based on validity." do
      wPawn = Pawn.new(1, [1,2], 'white')
      opArray = [Pawn.new(1, [2, 3], 'black')]
      wPawn2 = Pawn.new(2, [2,2], 'white')
      wPawn.checkCapture([2,3], opArray).should eq(true)
      wPawn2.checkCapture([3,4], opArray).should eq(false)
      opArray.should eq([])
    end
  end
  
  describe '#checkCapture - black' do 
    it "Accepts 2 params: destination coords as an array and opposing array. Returns true or false based on validity." do
      bPawn = Pawn.new(1, [1,7], 'black')
      opArray = [Pawn.new(1, [2,6], 'white')]
      bPawn2 = Pawn.new(2, [2,7], 'black')
      bPawn.checkCapture([2,6], opArray).should eq(true)
      bPawn2.checkCapture([3,7], opArray).should eq(false)
      opArray.should eq([])
    end
  end
  
  describe '#move' do
    it "Accepts 3 params: destination coords as an array, opposing array, and friendly array. Returns message according to action taken." do
      pawn = Pawn.new(1, [2,2], 'white')
      pawn2 = Pawn.new(2, [1,2], 'white')
      pawn3 = Pawn.new(1, [3,2], 'white')
      opArray = [Pawn.new(1, [3, 4], 'black')]
      frArray = []
      pawn3.move([3,3], opArray, frArray).should eq('Moved!')
      pawn3.move([3,4], opArray, frArray).should eq('Not Valid')
      pawn.move([2,3], opArray, frArray).should eq('Moved!')
      pawn.move([3,4], opArray, frArray).should eq('Capture!')
      opArray.should eq([])
      pawn2.move([2,3], opArray, frArray).should eq('Not Valid')
    end 
  end
end


describe Game do 
  describe '#new' do
    it "Fills two arrrays with opposing faction pieces (pawns, currently)" do
      game = Game.new
      for i in 1..8 
        game.whiteArray[i-1].position.should eq([i,2])
        game.whiteArray[i-1].color.should eq('white')
        game.whiteArray[i-1].type.should eq('pawn')
        game.whiteArray[i-1].id.should eq(i)
        game.blackArray[i-1].position.should eq([i,7])
        game.blackArray[i-1].color.should eq('black')
        game.blackArray[i-1].type.should eq('pawn')
        game.blackArray[i-1].id.should eq(i)
      end
    end
  end
  
  describe '#getPieceById' do
    it "Accepts 2 params: id and color. Returns Piece object." do
      game = Game.new
      wPawn = game.getPieceById(2, 'white')
      bPawn = game.getPieceById(4, 'black')
      wPawn.position.should eq([2,2])
      wPawn.color.should eq('white')
      bPawn.position.should eq([4,7])
      bPawn.color.should eq('black')
    end
  end
  
  describe '#movePiece' do
    it "Accepts 3 params: id, color, and destination as an array. Returns action taken message." do
      game = Game.new
      game.blackArray.push(Pawn.new(9, [3,3], 'black'))
      game.whiteArray.push(Pawn.new(9, [4,3], 'white'))
      game.movePiece(1, 'white', [1,4]).should eq('Moved!')
      game.movePiece(1, 'white', [3,3]).should eq('Not Valid')
      game.movePiece(3, 'white', [3,3]).should eq('Not Valid')
      game.movePiece(2, 'white', [3,3]).should eq('Capture!')
      game.blackArray.length.should eq(8)
      game.movePiece(4, 'white', [4,3]).should eq('Not Valid(friendly)')
    end
  end
end    