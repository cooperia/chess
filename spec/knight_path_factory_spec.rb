require 'spec_helper'

describe KnightPathFactory do
  let(:path_factory) { KnightPathFactory.new }

  describe '#generate_path' do
    it 'returns an empty array if destination is valid' do
      path_factory.generate_path(Move.new('D4', 'C6')).should == []
    end

    it 'returns an error if destination is not valid' do
      expect { path_factory.generate_path(Move.new('D4', 'D6')) }.to raise_error(RuntimeError, 'Invalid move for a knight')
    end
  end

  describe '#generate_moves' do
    it 'generates an array of legal moves' do
      should_be = [Coordinate.new('B3'), Coordinate.new('C2')]
      possible = path_factory.generate_moves(Coordinate.new('A1'))
      possible.each do |entry|
        should_be.any? { |location| location.equal?(entry) }.should == true
      end
    end
  end

  describe 'valid_move?' do
    it 'returns true if a destination is valid within the set of rules' do
      valid_moves = path_factory.generate_moves(Coordinate.new('A1'))
      path_factory.valid_move?(valid_moves, Coordinate.new('B3')).should == true
    end

    it 'returns false if it isnt' do
      valid_moves = path_factory.generate_moves(Coordinate.new('A1'))
      path_factory.valid_move?(valid_moves, Coordinate.new('A3')).should == false
    end
  end

end