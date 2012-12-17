require 'rubygems'
require 'rspec'
require '/Users/jasmina/Documents/Ruby/chess_ian/chess/chess.rb'
require 'cucumber'

describe Pieces do
  let(:piece){Piece.new('rook', 'black')}

  describe '#new' do
    it 'creates a new piece' do
      piece.type.should == 'rook'
      piece.color.should == 'black'
    end
  end

  describe '#error_catcher' do
    it 'catches invalid colors' do
      expect { piece.error_catcher('rook', 'purple') }.to raise_error(RuntimeError, 'Invalid color')
    end

    it 'catches invalid types' do
      expect { piece.error_catcher('bad', 'black') }.to raise_error(RuntimeError, 'Invalid type')
    end
  end
end