require 'rubygems'
require 'rspec'
require '/Users/jasmina/Documents/Ruby/chess_ian/chess/chess.rb'
require 'cucumber'

describe Pieces do
  let(:pieces) { Pieces.new }
  let(:current_piece_position) {pieces.collection[0][1]}
  let(:move) {Move.new('A1', 'B1')}

  before(:each) do
    pieces.place('rook', 'black', 'A1')

  end

  describe '#move' do
    it 'performs a move and returns true or false if it was successful' do
      a_piece = pieces.find_at(Coordinate.new('A1'))[0]
      pieces.move(move).eql?(Coordinate.new('B1')).should == true
      pieces.collection[0][0].should == a_piece
    end
  end

  describe '#capture_error_catcher' do
    it 'catches if the destination is occupied by the same color' do
      pieces.place('rook', 'black', 'B1')
      expect { pieces.capture_error_catcher(move) }.to raise_error(RuntimeError, 'Can\'t capture your own pieces!')
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
      expect { pieces.move_error_catcher(Move.new('B1', 'C1'))}.to raise_error(RuntimeError, 'No piece at position')
    end

    it 'catches invalid destination' do
      expect {pieces.move_error_catcher(Move.new('A1', 'Z1'))}.to raise_error(RuntimeError, 'Invalid Destination')
    end
  end

  describe '#perform_move' do
    it 'returns a piece with a new position' do
      piece = pieces.perform_move(Move.new('A1', 'C1'))
      piece.eql?(Coordinate.new('C1')).should == true
    end

    it 'calls #destroy_piece if capture is true' do
      pieces.should_receive(:destroy_piece)
      pieces.perform_move(move, true)
    end
  end

  describe '#destroy_piece' do
    it 'should destroy piece at destination' do
      pieces.place('rook', 'black', 'H8')
      pieces.destroy_piece(Coordinate.new('H8'))
      pieces.find_at(Coordinate.new('H8')).should == nil
    end
  end

  describe '#update_position' do
    it 'should update a piece\'s destination' do
      piece = pieces.collection[0]
      pieces.update_position(piece, Coordinate.new('A4'))
      piece[1].eql?(Coordinate.new('A4')).should == true
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