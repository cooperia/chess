require 'spec_helper'

describe Game do

  let(:pieces) { Pieces.new }
  let(:game) { Game.new(pieces) }

  describe '#move' do
    it 'calls move on the Move object' do
      Move.any_instance.should_receive(:move)
      game.move('A1', 'H1')
    end
  end
end