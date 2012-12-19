require 'rubygems'
require 'rspec'
require '/Users/jasmina/Documents//Ruby/chess_ian/chess/chess.rb'
require 'cucumber'

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

describe MoveFactory do
  let(:move_factory) { MoveFactory.new() }
  let(:move) { Move.new(['A',1], ['B',1]) }

  describe '#generate_move' do
    it "#generates a move using the appropriate set of rules based ona piece's type" do
       move_factory.generate_move(move, 'rook').should == 'RookRules'
    end
  end

  describe '#titleize' do
    it "#capitalizes the first letter of a string" do
      move_factory.titleize('rook').should == 'Rook'
    end
  end
end

