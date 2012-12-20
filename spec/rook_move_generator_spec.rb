require 'spec_helper'

describe RookMoveGenerator do
  #let(:rook_move_generator) { RookMoveGenerator.new(Coordinate.new('A1').generate) }

  describe '#generate_moves' do
    it 'excludes origin from list of possible moves' do
      moves = RookMoveGenerator.generate(Coordinate.new('A1'))
      moves.move_options.each do |entry|
        entry.equal?(Coordinate.new('A1')).should == false
      end
      moves.move_options.empty?.should == false
    end
  end

  describe '#generate_moves' do
    it 'takes an origin and generates an array of possible moves' do
      allowed_moves = [Coordinate.new('A2'), Coordinate.new('A3'), Coordinate.new('A4'), Coordinate.new('A5'), Coordinate.new('A6'), Coordinate.new('A7'), Coordinate.new('A8'), Coordinate.new('B1'), Coordinate.new('C1'), Coordinate.new('D1'), Coordinate.new('E1'), Coordinate.new('F1'), Coordinate.new('G1'), Coordinate.new('H1')]
      move_options = RookMoveGenerator.generate(Coordinate.new('A1'))
      move_options.move_options.each do |generated_move|
        allowed_moves.find {|allowed_move| allowed_move.equal?(generated_move)}.is_a?(Coordinate).should == true
      end
      RookMoveGenerator.generate(Coordinate.new('A1')).move_options.length.should == allowed_moves.length
    end
  end
end