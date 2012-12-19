require 'spec_helper'

describe RookPathFactory do
  let(:path_factory) { RookPathFactory.new }

  describe '#generate_path' do
    it 'generates a path that must be open to move a piece' do
      move = Move.new('A1', 'A4')
      path_factory.generate_path(move)[0].equal?(Coordinate.new('A2')).should == true
      path_factory.generate_path(move)[1].equal?(Coordinate.new('A3')).should == true
    end
  end

  describe 'valid_move?' do
    it 'returns true if a destination is valid within the set of rules' do
      valid_moves = path_factory.generate_moves(Coordinate.new('A1'))
      path_factory.valid_move?(valid_moves, Coordinate.new('A3')).should == true
    end

    it 'returns false if it isnt' do
      valid_moves = path_factory.generate_moves(Coordinate.new('A1'))
      path_factory.valid_move?(valid_moves, Coordinate.new('B3')).should == false
    end
  end

  describe '#generate_moves' do
    it 'takes a position and generates an array of possible moves' do
      moves = path_factory.generate_moves(Coordinate.new('A1'))
      moves.each do |entry|
        entry.equal?(Coordinate.new('A1')).should == false
      end
      moves.empty?.should == false
    end
  end

  describe '#generate_moves' do
    it 'takes a position and generates an array of possible moves' do

      allowed_moves = [Coordinate.new('A2'), Coordinate.new('A3'), Coordinate.new('A4'), Coordinate.new('A5'), Coordinate.new('A6'), Coordinate.new('A7'), Coordinate.new('A8'), Coordinate.new('B1'), Coordinate.new('C1'), Coordinate.new('D1'), Coordinate.new('E1'), Coordinate.new('F1'), Coordinate.new('G1'), Coordinate.new('H1')]
      path_factory.generate_moves(Coordinate.new('A1')).each do |generated_move|
        allowed_moves.find {|allowed_move| allowed_move.equal?(generated_move)}.is_a?(Coordinate).should == true
      end
      path_factory.generate_moves(Coordinate.new('A1')).length.should == allowed_moves.length
    end
  end

  describe '#horizontal_path_array' do
    it 'returns an array of squares that must be open for a given move' do
      path_factory.horizontal_path_array(['A1','C1'], Coordinate.new('A1')).first.equal?(Coordinate.new('B1')).should == true
    end
  end

  describe '#vertical_path_array' do
    it 'returns an array of squares for a vertical move' do
      path_factory.vertical_path_array(['A3', 'A8'], Coordinate.new('A3')).first.equal?(Coordinate.new('A4')).should == true
    end
  end

end