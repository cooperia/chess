require 'rubygems'
require 'rspec'
require '/Users/jasmina/Documents/Ruby/chess2/chess.rb'
require 'cucumber'

describe Pieces do
  let(:pieces) { Pieces.new }
  let(:current_piece_position) {pieces.collection[0][1]}

  before(:all) do
    pieces.place('rook', 'A1')
  end

  describe '#error_catcher' do
    let(:error_pieces) { Pieces.new }
    it "catches invalid type" do
      expect { pieces.error_catcher('bad', Coordinate.new('A3'))}.to raise_error(RuntimeError, 'Invalid type')
    end

    it "catches invalid position" do
      expect { pieces.error_catcher('rook', Coordinate.new('Z3'))}.to raise_error(RuntimeError, 'Invalid position')
    end

    it 'catches an occupied destination' do
      error_pieces.place('rook', 'A1')
      expect { error_pieces.error_catcher('rook', Coordinate.new('A1'))}.to raise_error(RuntimeError, 'Position occupied')
    end
  end

  describe '#place' do
    it 'positions a piece' do
      new_piece = pieces.place('rook', 'C5')
      pieces.collection.include?(new_piece).should == true
    end
  end

  describe '#valid_type?' do
    it "should determine if a type is valid" do
      pieces.valid_type?('bad').should == false
      pieces.valid_type?('rook').should == true
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
      pieces.find_at(Coordinate.new('A1')).should == ['rook', current_piece_position]
      #pieces.find_at(['B',1]).should_not == current_piece
    end
  end

  describe '#vacancy?' do
    it 'checks the vacancy of a destination' do
      pieces.vacancy?(Coordinate.new('A2')).should == true
      pieces.vacancy?(Coordinate.new('A1')).should == false
    end
  end
end