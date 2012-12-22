require 'spec_helper'


describe KnightPathGenerator do
  let(:board) {Board.new}
  before do
    board.place('rook', 'black', 'A1')
  end
  describe '#generate' do
    it 'returns an empty path object' do
      KnightPathGenerator.generate(Move.new('A1', 'B1', board)).is_a?(Path).should == true
    end
  end

end