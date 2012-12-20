require 'spec_helper'

describe RookMove do
  let(:rook_move) {RookMove.new}

  describe '#add' do
    it 'adds a coordinate to the list of possible options' do
      coordinate = Coordinate.new('A1')
      rook_move.add(coordinate)
      rook_move.move_options.should == [coordinate]
    end
  end

  describe '#includes?' do
    it 'should raise error in destination is not included in move_options' do
      rook_move.add(Coordinate.new('A1'))
      expect { rook_move.includes?(Coordinate.new('A3')) }.to raise_error(RuntimeError, 'Invalid move for a rook')
    end
  end

  describe '#valid_move' do
    it 'should return false if destination is not in move_options' do
      rook_move.add(Coordinate.new('A1'))
      rook_move.valid_move?(Coordinate.new('A3')).should == false
    end

    it 'should return true if destination is in move_options' do
      rook_move.add(Coordinate.new('A1'))
      rook_move.valid_move?(Coordinate.new('A1')).should == true
    end
  end

  describe '#reject' do
    it 'should an array of move options' do
      coordinate = Coordinate.new('A1')
      rook_move.add(coordinate)
      array = rook_move.reject(coordinate)
      array.any? {|entry| entry.equal?(Coordinate.new('A1'))}.should == false
    end
  end
end