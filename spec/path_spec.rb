require 'spec_helper'

describe Path do
  let(:path) {Path.new}

  describe '#size' do
    it 'returns the size (length) of the path' do
      path.add(Coordinate.new('A1'))
      path.size.should == 1
    end
  end

  describe '#clean' do
    it 'should remove extraneous positions from horizontal moves' do
      path.add(Coordinate.new('A1'))
      path.add(Coordinate.new('B1'))
      path.add(Coordinate.new('B2'))
      path.clean(Coordinate.new('C1'))
      path.included?(Coordinate.new('B2')).should == false
    end
  end

  describe '#add' do
    it 'adds a new coordinate object to the path' do
      path.add(Coordinate.new('A1'))
      path.included?(Coordinate.new('A1')).should == true
    end
  end

  describe '#included?' do
    it 'returns false if a position is not included' do
      path.add(Coordinate.new('A1'))
      path.included?(Coordinate.new('A2')).should == false
    end
  end

  describe '#obstructed?' do
    it 'takes a board array and determines if any pieces obstruct the path' do
      board = [Piece.new('rook', 'black', 'A1'), Piece.new('rook', 'black', 'B2')]
      path.add(Coordinate.new('A1'))
      path.add(Coordinate.new('A2'))
      expect {path.obstructed?(board)}.to raise_error(RuntimeError, 'Path obstructed')
    end
  end


end