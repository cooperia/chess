require 'spec_helper'

describe KnightMoveGenerator do
  let(:move_generator) { KnightMoveGenerator.new }

  describe '#generate_moves' do
    it 'generates an array of legal moves' do
      should_be = [Coordinate.new('B3'), Coordinate.new('C2')]
      possible = KnightMoveGenerator.generate(Coordinate.new('A1'))
      possible.move_options do |entry|
        should_be.any? { |location| location.equal?(entry) }.should == true
      end
    end
  end
end