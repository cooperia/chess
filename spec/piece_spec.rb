require 'spec_helper'

describe Piece do
  let(:piece){Piece.new('rook', 'black', 'A1')}
  let(:move) { Move.new('A1', 'A4', Board.new) }

  describe '#generate_move' do
    it 'generates possible moves using the piece\'s type' do
     piece.generate_move.is_a?(PossibleMoves).should == true
    end
  end

  describe '#generate_path' do
    it 'generates a path using the piece\'s type' do
      piece.generate_path(move).is_a?(Path).should == true
    end
  end

  describe '#new' do
    it 'creates a new piece' do
      piece.type.should == 'rook'
      piece.color.should == 'black'
      piece.position.equal?(Coordinate.new('A1')).should == true
    end
  end

  describe '#set_position' do
    it 'sets a new position for instance' do
      piece.set_position(Coordinate.new('A3'))
      piece.position.equal?(Coordinate.new('A3')).should == true
    end
  end

  describe '#titleize' do
    it "#capitalizes the first letter of a string" do
      piece.titleize('rook').should == 'Rook'
    end
  end
end