require 'rubygems'
require 'rspec'
require '/Users/ian/chess/chess.rb'
require 'cucumber'

describe Pieces do
  let(:pieces) { Pieces.new }
  let(:current_piece_position) {pieces.collection[0][1]}
  let(:move) {Move.new('A1', 'B1')}

  before(:all) do
    pieces.place('rook', 'black', 'A1')
  end

  describe '#move' do
    it 'performs a move and returns true or false if it was successful' do
      pieces.move(move).should == 'RookRules'
    end
  end

  describe '#place_error_catcher' do
    let(:error_pieces) { Pieces.new }
    it "catches invalid position" do
      expect { pieces.place_error_catcher(Coordinate.new('Z3'))}.to raise_error(RuntimeError, 'Invalid Position')
    end

    it 'catches an occupied destination' do
      error_pieces.place('rook', 'black', 'A1')
      expect { error_pieces.place_error_catcher(Coordinate.new('A1'))}.to raise_error(RuntimeError, 'Position occupied')
    end
  end

  describe '#move_error_catcher' do
    it 'catches no piece at position' do
      expect { pieces.move_error_catcher(Move.new('B1', 'Z1'))}.to raise_error(RuntimeError, 'No piece at position')
    end

    it 'catches invalid destination' do
      expect {pieces.move_error_catcher(Move.new('A1', 'Z1'))}.to raise_error(RuntimeError, 'Invalid Destination')
    end
  end

  describe '#path_check?' do
    it 'returns false if a path is obstructed' do
      expect { pieces.path_check?([Coordinate.new('A1'), Coordinate.new('A2')])}.to raise_error(RuntimeError, 'Path obstructed')
    end

    it 'returns true if path is unobstructed' do
      pieces.path_check?([Coordinate.new('A2'), Coordinate.new('A3')]).should == true
    end
  end

  describe '#place' do
    it 'positions a piece' do
      new_piece = pieces.place('rook', 'black', 'C5')
      pieces.collection.include?(new_piece).should == true
    end
  end

  describe '#valid_coordinates?' do
    it 'accepts a destination and determines if it is on the board' do
      pieces.valid_coordinates?(Coordinate.new('A1')).should == true
      pieces.valid_coordinates?(Coordinate.new('Z1')).should == false
    end
  end

  describe '#find_at' do
    it 'finds a piece by its position' do
      pieces.find_at(Coordinate.new('A1'))[0].type.should == 'rook'
    end
  end

  describe '#vacancy?' do
    it 'checks the vacancy of a destination' do
      pieces.vacancy?(Coordinate.new('A2')).should == true
      pieces.vacancy?(Coordinate.new('A1')).should == false
    end
  end
end