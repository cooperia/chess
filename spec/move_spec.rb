require 'spec_helper'

describe Move do
  let(:board) { Board.new }
  let(:move) { Move.new('A1', 'B1', board) }
  let(:piece) { Piece.new('rook', 'black', 'A1') }

  before do
    board.stub(:find_at).and_return(piece)
  end

  describe '#new' do
    it 'creates a new move instance with valid coordinates' do
      move.origin.x.should == 'A'
      move.origin.y.should == 1
    end

    context 'if position == destination' do
      it 'raises an error' do
        expect{ Move.new('A1', 'A1', board) }.to raise_error(RuntimeError, 'Position must be different from destination')
      end
    end

    context 'if coordinates are invalid' do
      it 'raise an error' do
        expect { Move.new('A2', 'Z1', board)}.to raise_error(RuntimeError, 'Invalid Coordinates')
      end
    end
  end

  describe '#valid?' do
    context 'if coordinates are different' do
      it 'returns true' do
        move.valid?.should == true
      end
    end
  end

  describe "#perform" do
    before do
      move.stub(:verify_move).and_return(true)
      move.stub(:verify_path?).and_return(true)
      move.stub(:complete).and_return(true)
    end

    it 'should call verify move' do
      move.should_receive(:verify_move)
      move.perform
    end

    context 'if verify path returns false' do
      before do
        move.stub(:verify_path?).and_return(false)
      end
      it 'doesnt complete the move' do
        move.should_not_receive(:complete)
        move.perform
      end
    end

    context 'if verify path returns true' do
      it 'completes the move' do
        move.should_receive(:complete)
        move.perform
      end
    end
  end

  describe "#complete" do
    it ' should call capture_at on board' do
      board.should_receive(:capture_at).with(move.destination, piece).and_return(true)
      piece.should_receive(:set_position).with(move.destination).and_return(true)
      move.complete(piece)
    end
  end

  describe '#verify_move' do
    let(:possible_moves_double) {double(PossibleMoves)}
    before do
      piece.stub(:generate_move).and_return(possible_moves_double)
      possible_moves_double.stub(:includes?).and_return(true)
    end

    it 'asks pieces to generate a move and asks that move if it includes the destination' do
      piece.should_receive(:generate_move).and_return(possible_moves_double)
      possible_moves_double.should_receive(:includes?).and_return(true)
      move.verify_move
    end

    context 'if includes? returns true' do
      it 'returns true' do
        move.verify_move.should == true
      end
    end

    context 'otherwise, an exception will be raised' do

    end
  end

  describe '#verify_path?' do
    let(:path_double) {double(Path)}
    before do
      piece.stub(:generate_path).and_return(path_double)
      path_double.stub(:obstructed?).and_return(true)
    end
    it 'should ask piece to generate a path and ask the path if it is obstructed' do
      piece.should_receive(:generate_path).with(move)
      move.verify_path?
    end
    context 'if the path is unobstructed' do
      it 'will return true' do
        move.verify_path?.should == true
      end
    end

    context 'if the path is obstructed' do
      it 'will do nothing but an exception will be raised elsewhere' do

      end
    end


  end

  describe '#errors' do
    context 'if valid? is false' do
      it 'calls an error method' do
        move.stub(:legal?).and_return(true)
        move.stub(:valid?).and_return(false)
        expect{ move.errors }.to raise_error(RuntimeError, 'Position must be different from destination')
      end
    end
    context 'if legal? is false' do
      it 'calls an error method' do
        move.stub(:legal?).and_return(false)
        move.stub(:valid?).and_return(true)
        expect{ move.errors }.to raise_error(RuntimeError, 'Invalid Coordinates')
      end
    end
  end

  describe 'equal' do
    context 'if object\'s coordinates are equal' do
      it 'returns true' do
        new_object = Move.new('A1', 'B1', board)
        new_object.equal?(move).should == true
      end
    end

    context 'if object\'s coordinates are not equal' do
      it 'returns false if two objects coordinates are not equal' do
        new_object = Move.new('A3', 'B3', board)
        new_object.equal?(move).should == false
      end
    end
  end

  describe '#legal?' do
    it 'should return true for valid position and destination' do
      move.legal?.should == true
    end

    it 'should return false for invalid position' do
      expect { Move.new('A9', 'B4', board).legal? }.to raise_error(RuntimeError, 'Invalid Coordinates')
    end

    it 'should return true for valid position and destination' do
      expect { Move.new('A3', 'X4', board).legal? }.to raise_error(RuntimeError, 'Invalid Coordinates')
    end
  end
end