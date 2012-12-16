require 'rubygems'
require 'rspec'
require '/Users/ian/chess/chess.rb'
require 'cucumber'

describe RookRules do
  let(:rules) { RookRules.new }

  describe '#generate_path' do
    it 'generates a path that must be open to move a piece' do
      rules.generate_path(move)[0].eql?(Coordinate.new('A2')).should == true
      rules.generate_path(move)[1].eql?(Coordinate.new('A3')).should == true
    end
  end

  describe 'valid_move?' do
    it 'returns true if a destination is valid within the set of rules' do
      valid_moves = rules.generate_moves(Coordinate.new('A1'))
      rules.valid_move?(valid_moves, Coordinate.new('A3')).should == true
    end

    it 'returns false if it isnt' do
      valid_moves = rules.generate_moves(Coordinate.new('A1'))
      rules.valid_move?(valid_moves, Coordinate.new('B3')).should == false
    end
  end

  describe '#generate_moves' do
    it 'takes a position and generates an array of possible moves' do
      moves = rules.generate_moves(Coordinate.new('A1'))
      moves.each do |entry|
        entry.eql?(Coordinate.new('A1')).should == false
      end
      moves.empty?.should == false
    end
  end

  describe '#generate_moves' do
    it 'takes a position and generates an array of possible moves' do

      allowed_moves = [Coordinate.new('A2'), Coordinate.new('A3'), Coordinate.new('A4'), Coordinate.new('A5'), Coordinate.new('A6'), Coordinate.new('A7'), Coordinate.new('A8'), Coordinate.new('B1'), Coordinate.new('C1'), Coordinate.new('D1'), Coordinate.new('E1'), Coordinate.new('F1'), Coordinate.new('G1'), Coordinate.new('H1')]
      rules.generate_moves(Coordinate.new('A1')).each do |generated_move|
        allowed_moves.find {|allowed_move| allowed_move.eql?(generated_move)}.is_a?(Coordinate).should == true
      end
      rules.generate_moves(Coordinate.new('A1')).length.should == allowed_moves.length
    end
  end

end