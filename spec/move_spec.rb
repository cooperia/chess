require 'rubygems'
require 'rspec'
require '/Users/jasmina/Documents/Ruby/chess_ian/chess/chess.rb'
require 'cucumber'

describe Move do
  let(:move) { Move.new('A1', 'B1') }

  describe '#new' do
    it 'creates a new move instance with valid coordinates' do
      move.position.x.should == 'A'
      move.position.y.should == 1
    end

    it 'raises an error if position == destination' do
      expect{ Move.new('A1', 'A1') }.to raise_error(RuntimeError, 'Position must be different from destination')
    end
  end

  describe '#valid?' do
    it 'returns false if move and destination are the same' do
      move.valid?('A1', 'A1').should == false
    end
  end

  describe '#error' do
    it 'raises error' do
      expect{ move.error }.to raise_error(RuntimeError, 'Position must be different from destination')
    end
  end
end