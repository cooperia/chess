require 'spec_helper'

describe Game do

  let(:board) { Board.new }
  let(:game) { Game.new(board) }

  describe '#move' do
    before do
      board.place('rook', 'black', 'A1')
    end
    it 'calls move on the Move object' do
      Move.any_instance.should_receive(:perform).and_return(true)
      game.move('A1', 'H1')
    end
  end

  describe '#print_board' do
    it 'should print an empty board' do
      game.print_board.should == " 8 [    ][    ][    ][    ][    ][    ][    ][    ]\n 7 [    ][    ][    ][    ][    ][    ][    ][    ]\n 6 [    ][    ][    ][    ][    ][    ][    ][    ]\n 5 [    ][    ][    ][    ][    ][    ][    ][    ]\n 4 [    ][    ][    ][    ][    ][    ][    ][    ]\n 3 [    ][    ][    ][    ][    ][    ][    ][    ]\n 2 [    ][    ][    ][    ][    ][    ][    ][    ]\n 1 [    ][    ][    ][    ][    ][    ][    ][    ]\n ___  A __  B __  C __  D __  E __  F __  G __  H _\n"
    end
  end
end