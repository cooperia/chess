require 'rubygems'
require 'rspec'
require '/Users/jasmina/Documents/Ruby/chess2/chess.rb'
require 'cucumber'
#require 'cucumber/rake/task'
#
#Cucumber::Rake::Task.new


describe Game do
  
  let(:pieces) { Pieces.new }
  let(:game) { Game.new(pieces) }
  
  describe '#move' do
    it "accepts a hash containing position and destination returns true if valid move" do
      expect { game.move(['A',1], ['Z',1])}.to raise_error(RuntimeError, 'Invalid destination')
      
      # piece = mock('Piece').stub(:move?).and_return true
      #       
      #       pieces = Pieces.new([piece])
      #       Game.new(pieces)
      #       
    end
    
    it 'returns capture if destination is occupied' do
      game.move(['A',1], ['B',1]).should == 'capture'
    end
    
    it 'return move if destination is vacant' do
      game.move(['A', 1], ['B',2]).should == 'move'
    end
    
    it 'returns No piece there! if moving_piece is nil' do
      expect { game.move(['C', 1], ['B',2])}.to raise_error(RuntimeError, 'No piece there!')
    end
  end


end

describe Pieces do
  let(:pieces) { Pieces.new }
  let(:current_piece) {pieces.collection[0]}

  describe '#error_catcher' do
    it "catches invalid type" do
      expect { pieces.error_catcher('bad', ['A',3])}.to raise_error(RuntimeError, 'Invalid type')
    end

    it "catches invalid position" do
      expect { pieces.error_catcher('rook', ['Z',3])}.to raise_error(RuntimeError, 'Invalid position')
    end

    it 'catches an occupied destination' do
      expect { pieces.error_catcher('rook', ['A', 1])}.to raise_error(RuntimeError, 'Position occupied')
    end
  end

  describe '#place' do
    it 'positions a piece' do
      new_piece = pieces.place('rook', ['A',3])
      pieces.collection.include?(new_piece).should == true
    end
  end

  describe '#valid_type?' do
    it "should determine if a type is valid" do
      pieces.valid_type?('bad').should == false
      pieces.valid_type?('rook').should == true
    end
  end

  describe '#valid_coordinates?' do
    it 'accepts a destination and determines if it is on the board' do
      pieces.valid_coordinates?(['A',1]).should == true
      pieces.valid_coordinates?(['Z',1]).should == false
    end
  end
  
  describe '#find_at' do
    it 'finds a piece by its position' do
      pieces.find_at(['A',1]).should == current_piece
      pieces.find_at(['B',1]).should_not == current_piece
    end
  end
  
  describe '#vacancy?' do
    it 'checks the vacancy of a destination' do
      pieces.vacancy?(['A',2]).should == true
      pieces.vacancy?(['A',1]).should == false
    end
  end
end

describe Piece do
  let(:type){'rook'}
  let(:piece) {Piece.new(type, ['A',2])}


  describe '#new' do
    it "creates a piece and takes position" do
      piece.position
    end
  end
  
  describe '#capture?' do
    it "checks if a destination is a legal capture" do
      piece.capture?('destination').should == 'capture'
    end
  end
  
  describe '#move?' do
    it "checks if a destination is a legal move" do
      piece.move?('destination').should == 'move'
    end
  end

  describe "#legal_destination" do
    it "should return false if destination is not in allowed moves" do
      piece.legal_destination?(['H', 1],[ ['A',1], ['B',1]]).should == false
      piece.legal_destination?(['A', 1],[ ['A',1], ['B',1]]).should == true
    end
  end
end

describe Rook do
  let(:rook) { Rook.new(['H',1]) }

  describe "#new" do
    it "creates new rook and accepts position attribute" do
      rook.position.should == ['H', 1]
    end
  end

  describe '#capture?' do
    it 'calls #move? and returns move' do
      rook.capture?('dummy') .should == 'move'
    end

    it 'returns move' do
      rook.move?('dummy') .should == 'move'
    end
  end

end

describe RookRules do
  let(:rules) { RookRules.new }

  describe '#generate_moves' do
    it 'takes a position and generates an array of possible moves' do
      moves = rules.generate_moves(['A',1])
      moves.each do |entry|
        entry.should_not == ['A', 1]
      end
      moves.empty?.should == false
    end
  end

  describe '#generate_moves' do
    it 'takes a position and generates an array of possible moves' do

      allowed_moves = [['A',2], ['A',3], ['A',4], ['A',5], ['A',6], ['A',7], ['A',8], ['B',1], ['C',1], ['D',1], ['E',1], ['F',1], ['G',1], ['H',1]]
      rules.generate_moves(['A',1]) =~ allowed_moves
      rules.generate_moves(['A',1]).length.should == allowed_moves.length
    end
  end

end

describe Coordinates do
  let(:coordinates) { Coordinates.new(['A',1]) }

  describe '#new' do
    it 'accepts an array and creates an object with x andy coords' do
      coordinates.x.should == 'A'
      coordinates.y.should == 1
    end
  end
end

describe Move do
  let(:move) { Move.new(['A',1], ['B',1]) }

  describe '#new' do
    it 'creates a new move instance with valid coordinates' do
      move.position.x.should == 'A'
      move.position.y.should == 1
    end
  end

end

