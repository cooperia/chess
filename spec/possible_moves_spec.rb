require 'spec_helper'

describe PossibleMoves do
  let(:possible_move) {PossibleMoves.new}

  describe '#add' do
    it 'adds a coordinate to the list of possible options' do
      coordinate = Coordinate.new('A1')
      possible_move.add(coordinate)
      possible_move.move_options.should == [coordinate]
    end
  end

  describe '#includes?' do
    it 'should raise error in destination is not included in move_options' do
      possible_move.add(Coordinate.new('A1'))
      expect { possible_move.includes?(Coordinate.new('A3')) }.to raise_error(RuntimeError, 'Invalid move for a rook')
    end
  end

  describe '#valid_move' do
    it 'should return false if destination is not in move_options' do
      possible_move.add(Coordinate.new('A1'))
      possible_move.valid_move?(Coordinate.new('A3')).should == false
    end

    it 'should return true if destination is in move_options' do
      possible_move.add(Coordinate.new('A1'))
      possible_move.valid_move?(Coordinate.new('A1')).should == true
    end
  end

  describe '#remove' do
    it 'should an array of move options' do
      coordinate = Coordinate.new('A1')
      possible_move.add(coordinate)
      array = possible_move.remove(coordinate)
      array.any? {|entry| entry.equal?(Coordinate.new('A1'))}.should == false
    end
  end
  
  describe '#clean' do
    let(:possible_moves2) { PossibleMoves.new}
    let(:legal_coordinate) { Coordinate.new('A1') }
    let(:illegal_coordinate) { Coordinate.new('Z1') }
    it 'should remove all illegal coordinates' do

      possible_moves2.add(illegal_coordinate)
      possible_moves2.add(legal_coordinate)
      possible_moves2.clean
      possible_moves2.move_options.include?(legal_coordinate).should == true
      possible_moves2.move_options.include?(illegal_coordinate).should == false

    end
  end
end