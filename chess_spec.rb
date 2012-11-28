require '~/Documents/Ruby/chess/chess.rb'

describe Piece do
  describe '#new' do
    it "Accepts 2 params: start position and color. Returns Piece object" do
      piece = Piece.new(:position => [1,2], :color => 'white')
      piece.position.should eq([1,2])
      piece.color.should eq('white')
      piece.start.should eq(true)
    end
  end
  
  describe '#check_position_vacancy' do
    it "Accepts a pieces array and a destination and determines if dest is occupied" do
      pieces = []
      piece = Piece.new(:position => [1,2], :color => 'white')
      pieces.push(Pawn.new(:position => [1,4], :color => 'white'))
      piece.check_position_vacancy?([1,4], pieces).should eq(false)
    end
  end
  
  describe '#check_occupant_color' do
    it "Accepts a pieces array and a destination and the color of the occupying piece" do
      pieces = []
      piece = Piece.new(:position => [1,2], :color => 'white')
      pieces.push(Pawn.new(:position => [1,4], :color => 'black'))
      piece.check_occupant_color([1,4], pieces).should eq("black")
    end
  end
  
  describe '#check_move_validity' do
    it "Accepts a pieces array and determines if dest is on the board" do
      piece = Piece.new(:position => [1,1], :color => 'white')
      piece.check_move_validity?([0,4]).should eq(false)
      piece.check_move_validity?([1,4]).should eq(true)
    end
  end
  
end

describe Pawn do
  describe '#check_double_move' do
    it "Accepts the pieces array and determines if a move double move is legal" do
      pawn = Pawn.new(:position => [1,2], :color => 'white')
      pieces = [Pawn.new(:position => [1,3], :color => 'white')]
      pawn.check_double_move?(pieces).should eq(false)
    end
  end
  
  describe '#check_move_legality' do
    it "Accepts destination and pieces array to determin if a move is legal" do
      pawn = Pawn.new(:position => [1,2], :color => 'white')
      pieces = [Pawn.new(:position => [1,4], :color => 'white')]
      pawn.check_move_legality?([1,3], pieces).should eq(true)
      pawn.check_move_legality?([1,4], pieces).should eq(false)
      pawn.check_move_legality?([1,5], pieces).should eq(false)
    end
  end
  
  describe '#check_capture_legality' do
    it "Accepts destination and determins if destination is a legal capture location" do
      pawn = Pawn.new(:position => [1,2], :color => 'white')
      pawn.check_capture_legality?([1,3]).should eq(false)
      pawn.check_capture_legality?([2,3]).should eq(true)
    end
  end
  
  describe '#check_capture' do
    it "Accepts destination and pieces array to determin if a capture possible" do
      pawn = Pawn.new(:position => [1,2], :color => 'white')
      pieces = [Pawn.new(:position => [2,3], :color => 'black')]
      pawn.check_capture?([1,3], pieces).should eq(false)
      pawn.check_capture?([2,3], pieces).should eq(true)
    end
  end
  
  describe '#move' do
    it "Accepts destination and pieces array, performs appropriate action and catches illegality." do
      pawn = Pawn.new(:position => [1,2], :color => 'white')
      pawn2 = Pawn.new(:position => [3,2], :color => 'white')
      pieces = [Pawn.new(:position => [1,4], :color => 'white'), Pawn.new(:position => [2,3], :color => 'black')]
      pawn.move([1,4], pieces).should eq("Illegal Move")
      pawn.move([1,5], pieces).should eq("Illegal Move")
      pawn.move([2,4], pieces).should eq("Illegal Capture")
      pawn.move([2,3], pieces).should eq([2,3])
      pawn2.move([0,4], pieces).should eq ("Invalid Destination")
      pawn2.move([3,3], pieces).should eq([3,3])
    end
  end
end

describe Game do
  describe '#new' do
    it "Fills a pieces array with white and black pieces" do
      game = Game.new
      for i in 0..7
        game.pieces[i*2].color.should eq('white')
        game.pieces[i*2+1].color.should eq('black')
      end
    end
  end
  
  describe '#move_piece' do
    it "Accepts position of piece in question and destination, performs move." do
      game = Game.new
      game.move_piece([1,2], [1,3]).should eq([1,3])
      game.move_piece([1,2], [2,3]).should eq("Illegal Capture")
    end
  end
end