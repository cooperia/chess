require 'rubygems'
require 'rspec'
require '/Users/ian/chess/chess.rb'
require 'cucumber'

describe Game do

  let(:pieces) { Pieces.new }
  let(:game) { Game.new(pieces) }

  before(:all) do
    pieces.place('rook', 'A1')
    pieces.place('rook', 'B1')
  end

  #describe '#test' do
  #  it 'tests stuff' do
  #    pieces.stub(:find_at).and_return(true)
  #    game.test.should == true
  #  end
  #end

  describe '#move' do
    it 'creates a new move object from the arguments passed in and calls pieces.move' do
      pieces.stub(:move).and_return(true)
      game.move('A1', 'Z1').should == true
    end


    #it "returns Invalid Destination if the destination isnt ont he board" do
    #  expect { game.move('A1', 'Z1')}.to raise_error(RuntimeError, 'Invalid destination')
    #
    #  # piece = mock('Piece').stub(:move?).and_return true
    #  #
    #  #       pieces = Pieces.new([piece])
    #  #       Game.new(pieces)
    #  #
    #end
    #
    #it 'returns capture if destination is occupied' do
    #  game.move(['A',1], ['B',1]).should == 'capture'
    #end
    #
    #it 'return move if destination is vacant' do
    #  game.move(['A', 1], ['B',2]).should == 'move'
    #end
    #
    #it 'returns No piece there! if moving_piece is nil' do
    #  expect { game.move(['C', 1], ['B',2])}.to raise_error(RuntimeError, 'No piece there!')
    #end
  end

  describe '#moveifier' do
    it 'creates a new move object fromt he arguments passed in and calls pieces.move' do
      Move.new('A1', 'Z1').eql?(game.moveifier('A1', 'Z1')).should == true
    end
  end
end