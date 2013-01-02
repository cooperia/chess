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
    let(:piece) {Piece.new('rook', 'black', 'A1')}
    let(:destination) {Coordinate.new('B1')}
    let(:target_piece) {Piece.new('rook', 'white', 'B1')}
    it 'should find a capturable piece and call complete_capture' do
      board.should_receive(:find_at).with(destination)
      board.capture_at(destination, piece)
    end

    context 'capture is a Piece' do
      it 'should call #complete_capture' do
        board.stub(:find_at) {target_piece}
        board.should_receive(:complete_capture).with(piece, target_piece, destination)
        board.capture_at(destination, piece)
      end
    end

    context 'capture is not a Piece' do
      it "should not call #complete_capture" do
        board.stub(:find_at) {nil}
        board.should_not_receive(:complete_capture)
        board.capture_at(destination, piece)
      end
    end
  end

  describe '#complete_capture' do
    let(:piece) {Piece.new('rook', 'black', 'A1')}
    let(:destination) {Coordinate.new('B1')}
    let(:target_piece) {Piece.new('rook', 'white', 'B1')}

    it 'should call capture_errors' do
      board.should_receive(:capture_errors).with(piece, target_piece).and_return(true)
      board.complete_capture(piece, target_piece, destination)
    end

    it 'should call remove_piece' do
      board.should_receive(:remove_piece).with(destination)
      board.complete_capture(piece, target_piece, destination)
    end
  end

  describe '#capture_errors' do
    let(:piece) {board.find_at(Coordinate.new('A1'))}
    let(:target_piece) {board.find_at(Coordinate.new('B1'))}
    context 'if the piece at destination is the same color as the capturing piece' do
      before do
        board.place('rook', 'black', 'B1')
      end
      it 'raises and exception' do
        expect{board.capture_errors(piece, target_piece)}.to raise_error(RuntimeError, 'Can\'t capture your own pieces!')
      end
    end
  end

  describe '#place' do
    it 'checks for errors, then positions a piece' do
      board.should_receive(:place_error_catcher)
      new_piece = board.place('rook', 'black', 'C5')
      board.collection.include?(new_piece).should == true
    end
  end

  describe '#place_error_catcher' do
    context 'if destination is occupied' do
      it 'it raises and exception' do
        expect { board.place_error_catcher(Coordinate.new('A1'))}.to raise_error(RuntimeError, 'Position occupied')
      end
    end

    context 'if the destination is unoccupied' do
      it 'should not raise anything' do
        board.place_error_catcher(Coordinate.new('A2'))
      end
    end

  end
end