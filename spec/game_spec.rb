require 'spec_helper'

describe Game do

  let(:board) { Board.new }
  let(:game) { Game.new(board) }
  before do
    board.place('rook', 'black', 'A1')
  end

  describe '#move' do
    it 'calls move on the Move object' do
      Move.any_instance.should_receive(:perform).and_return(true)
      game.move('A1', 'H1')
    end
  end
end