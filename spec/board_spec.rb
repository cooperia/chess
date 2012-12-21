require 'spec_helper'

describe Board do
  let(:board) { Board.new }
  let(:move) {Move.new('A1', 'B1', board)}

  before(:each) do
     board.place('rook', 'black', 'A1')
  end

  describe '#find_at' do
    it 'finds a piece by its position' do
      board.find_at(Coordinate.new('A1')).type.should == 'rook'
    end
  end

  describe '#capture_at' do
    let(:piece) {board.find_at(Coordinate.new('A1'))}
    it 'should call capture_errors' do
      board.should_receive(:capture_errors).with(piece).and_return(true)
      board.capture_at(move.destination, piece)
    end
  end








  describe '#place' do
    it 'positions a piece' do
      new_piece = pieces.place('rook', 'black', 'C5')
      pieces.collection.include?(new_piece).should == true
    end
  end

  describe '#get_moving_piece' do
    it 'returns a piece at the specified position' do
      move2 = Move.new('A2', 'B1')
      piece2 = pieces.place('rook', 'black', 'A2')
      pieces.get_moving_piece(move2).should == piece2
    end

    it 'raises an exception if there is no piece at position' do
      bad_move = Move.new('B1', 'C1')
      expect { pieces.get_moving_piece(bad_move) }.to raise_error(RuntimeError, 'No piece at position')
    end
  end

  describe '#complete move' do
    it 'should verify complete regular move methods' do
      piece = Piece.new('rook','black','A1')
      path = [Coordinate.new('A2'), Coordinate.new('A3')]
      pieces.should_receive(:path_check?).with(path)
      pieces.should_receive(:check_move_type).with(move).and_return('regular')
      pieces.should_receive(:complete_regular_move).with(piece, move)
      pieces.complete_move(piece, path, move)
    end

    it 'should verify complete capture move methods' do
      piece = Piece.new('rook','black','A1')
      path = [Coordinate.new('A2'), Coordinate.new('A3')]
      pieces.place('rook', 'white', 'B1')
      pieces.should_receive(:path_check?).with(path)
      pieces.should_receive(:check_move_type).with(move).and_return('capture')
      pieces.should_receive(:complete_capture_move).with(piece, move)
      pieces.complete_move(piece, path, move)
    end
  end

  describe '#check_move_type' do
    it 'should return regular if destination is vacant' do
      pieces.check_move_type(move).should == 'regular'
    end

    it 'should return capture if destination is occupied' do
      pieces.place('rook', 'black', 'B1')
      pieces.check_move_type(move).should == 'capture'
    end
  end

  describe '#complete_regular_move' do
    it 'updates the position of a piece and returns true' do
      piece = Piece.new('rook','black','A1')
      pieces.complete_regular_move(piece, move).should == true
      piece.position.equal?(Coordinate.new('B1')).should == true
    end
  end

  describe '#compete_capture_move' do
    it 'performs a capture move' do
      piece = Piece.new('rook','black','A1')
      pieces.should_receive(:capture_error_catcher).with(move)
      pieces.should_receive(:destroy_piece).with(move.destination)
      pieces.should_receive(:complete_regular_move).with(piece, move)
      pieces.complete_capture_move(piece, move)
    end
  end

  describe '#capture_error_catcher' do
    it 'catches if the destination is occupied by the same color' do
      pieces.place('rook', 'black', 'B1')
      expect { pieces.capture_error_catcher(move) }.to raise_error(RuntimeError, 'Can\'t capture your own pieces!')
    end
  end

  describe '#place_error_catcher' do
    let(:error_pieces) { Board.new }

    it 'catches an occupied destination' do
      error_pieces.place('rook', 'black', 'A1')
      expect { error_pieces.place_error_catcher(Coordinate.new('A1'))}.to raise_error(RuntimeError, 'Position occupied')
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
      piece = pieces.collection.first
      pieces.update_position(piece, Coordinate.new('A4'))
      piece.position.equal?(Coordinate.new('A4')).should == true
    end
  end

  describe "#obstructed" do

    context "if the path is obstructed" do

      before do
        pieces.should_receive(:vacancy?).and_return(false)
      end

      it "it should return true" do

      end
    end

    context "if the path is NOT obstructed" do
      it "should return false" do

      end
    end
  end

  #describe '#path_check?' do
  #  it 'returns false if a path is obstructed' do
  #    expect { pieces.path_check?([Coordinate.new('A1'), Coordinate.new('A2')])}.to raise_error(RuntimeError, 'Path obstructed')
  #  end
  #
  #  it 'returns true if path is unobstructed' do
  #    pieces.path_check?([Coordinate.new('A2'), Coordinate.new('A3')]).should == true
  #  end
  #end



  describe '#vacancy?' do
    it 'checks the vacancy of a destination' do
      pieces.vacancy?(Coordinate.new('A2')).should == true
      pieces.vacancy?(Coordinate.new('A1')).should == false
    end
  end
end