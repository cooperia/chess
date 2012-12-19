require 'spec_helper'

describe Move do
  let(:move) { Move.new('A1', 'B1') }
  let(:pieces) { Pieces.new }

  describe '#new' do
    it 'creates a new move instance with valid coordinates' do
      move.position.x.should == 'A'
      move.position.y.should == 1
    end

    it 'raises an error if position == destination' do
      expect{ Move.new('A1', 'A1') }.to raise_error(RuntimeError, 'Position must be different from destination')
    end
  end

  describe '#valid?' do
    it 'returns false if move and destination are the same' do
      move.valid?('A1', 'A1').should == false
    end
  end

  describe '#error' do
    it 'raises error' do
      expect{ move.error }.to raise_error(RuntimeError, 'Position must be different from destination')
    end
  end

  describe 'equal' do
    it 'returns true if two objects coordinates are equal' do
      new_object = Move.new('A1', 'B1')
      new_object.equal?(move).should == true
    end

    it 'returns false if two objects coordinates are not equal' do
      new_object = Move.new('A3', 'B3')
      new_object.equal?(move).should == false
    end
  end

  describe '#move' do
    it 'should call move methods' do
      piece = Piece.new('rook','black','A1')
      pieces.stub(:get_moving_piece).with(move).and_return(piece)
      piece.should_receive(:generate_allowed_path)
      pieces.should_receive(:complete_move)
      move.move(pieces)
    end
  end

  describe '#arranger' do
    it 'return an array of position and destination, smallest to largest as strings' do
      backwards_move = Move.new('C1', 'A1')

      backwards_move.arranger.should == ['A1', 'C1']
    end
  end

  describe '#get_direction' do
    it 'returns vertical if the direction of travel is vertical' do
      move.get_direction.should == 'horizontal'
    end
  end

end