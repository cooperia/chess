require 'rubygems'
require 'rspec'
require '/Users/jasmina/Documents/Ruby/chess2/chess.rb'

describe Game do
  
  let(:pieces) { Pieces.new }
  let(:game) { Game.new(pieces) }
  
  it 'has pieces' do 
    game.pieces
  end
  
  describe '#new' do
    it "Starts a game" do
      game.pieces == pieces
      end
  end
  
  describe '#move_piece' do
    it "accepts a hash containing position and destination returns true if valid move" do
      # current_position = game.move_piece({:current_position => ['A',1], :destination => ['A', 2]})
      # current_position[:current_position].should eq(['A',1])
      # current_position[:destination].should eq(['A',2])
      # piece = mock('Piece').stub(:move?).and_return true
      #       
      #       pieces = Pieces.new([piece])
      #       Game.new(pieces)
      #       
    end
  end
  
  
end

describe Pieces do
  let(:pieces) { Pieces.new }
  let(:current_piece) {pieces.collection[0]}
  let(:dest) {['A',2]}
  
  describe '#new' do
    it "creates a collection array" do
      pieces.collection[0].should == current_piece
      
    end
  end
  
  describe '#find_piece_by_position' do
    it 'finds a piece from current position' do
      pieces.find_piece_by_position(['A',1]).should == current_piece
    end
  end
  
  describe '#check_destination_vacancy?' do
    it 'checks the vacancy of a destination' do
      pieces.check_destination_vacancy?(dest).should == ['A',2]
    end
  end
end

describe Piece do
  let(:piece) {Piece.new(['A',2])}
  
  describe '#new' do
    it "creates a piece and takes position" do
      piece.position
    end
  end
  
  describe '#capture?' do
    it "checks if a destination is a legal capture" do
      piece.capture?('destination').should == false
    end
  end
  
  describe '#move?' do
    it "checks if a destination is a legal move" do
      piece.move?('destination').should == true
    end
  end
end