require 'spec_helper'

describe RookPathGenerator do

  describe '#generate' do
    it 'generates a path that must be open to move a piece' do
      move = Move.new('A1', 'A4', Pieces.new)
      path = RookPathGenerator.generate(move)
      path.included?(Coordinate.new('A2')).should == true
      path.included?(Coordinate.new('A3')).should == true
      path.included?(Coordinate.new('A4')).should == false
    end
  end

  describe '#horizontal?' do
    it 'returns true if the path\'s size is greater than 6 (horizontal move)' do
      generator = RookPathGenerator.new(Move.new('A1', 'B1', Pieces.new))
      (1..8).each do |i|
        generator.path.add(Coordinate.new('A'+i.to_s))
      end
      generator.horizontal?.should == true

    end
  end

  describe '#cleaner' do
    it 'asks the path to clean itself of extraneous positions for horizontal moves' do
        generator = RookPathGenerator.new(Move.new('A1', 'B1', Pieces.new))
        (1..8).each do |i|
          generator.path.add(Coordinate.new('A'+i.to_s))
        end
        generator.cleaner
        generator.path.size.should == 1
    end
  end

  describe '#arranger' do
    it 'return an array of position and destination, smallest to largest as strings' do
      generator = RookPathGenerator.new(Move.new('C1', 'A1', Pieces.new))
      generator.arranger.should == ['A1', 'C1']
    end
  end
end


  #describe 'valid_move?' do
  #  it 'returns true if a destination is valid within the set of rules' do
  #    valid_moves = path_generator.generate_moves(Coordinate.new('A1'))
  #    path_generator.valid_move?(valid_moves, Coordinate.new('A3')).should == true
  #  end
  #
  #  it 'returns false if it isnt' do
  #    valid_moves = path_generator.generate_moves(Coordinate.new('A1'))
  #    path_generator.valid_move?(valid_moves, Coordinate.new('B3')).should == false
  #  end
  #end
  #
  #describe '#generate_moves' do
  #  it 'takes a position and generates an array of possible moves' do
  #    moves = path_generator.generate_moves(Coordinate.new('A1'))
  #    moves.each do |entry|
  #      entry.equal?(Coordinate.new('A1')).should == false
  #    end
  #    moves.empty?.should == false
  #  end
  #end
  #
  #describe '#generate_moves' do
  #  it 'takes a position and generates an array of possible moves' do
  #
  #    allowed_moves = [Coordinate.new('A2'), Coordinate.new('A3'), Coordinate.new('A4'), Coordinate.new('A5'), Coordinate.new('A6'), Coordinate.new('A7'), Coordinate.new('A8'), Coordinate.new('B1'), Coordinate.new('C1'), Coordinate.new('D1'), Coordinate.new('E1'), Coordinate.new('F1'), Coordinate.new('G1'), Coordinate.new('H1')]
  #    path_generator.generate_moves(Coordinate.new('A1')).each do |generated_move|
  #      allowed_moves.find {|allowed_move| allowed_move.equal?(generated_move)}.is_a?(Coordinate).should == true
  #    end
  #    path_generator.generate_moves(Coordinate.new('A1')).length.should == allowed_moves.length
  #  end
  #end
  #
  #describe '#path_array' do
  #  it 'returns an array of squares that must be open for a given move' do
  #    path_generator.path_array(['A1','C1'], Coordinate.new('A1')).first.equal?(Coordinate.new('B1')).should == true
  #  end
  #end