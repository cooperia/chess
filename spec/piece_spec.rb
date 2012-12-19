require 'spec_helper'

describe Pieces do
  let(:piece){Piece.new('rook', 'black', 'A1')}
  let(:move) { Move.new('A1', 'A4') }

  describe '#new' do
    it 'creates a new piece' do
      piece.type.should == 'rook'
      piece.color.should == 'black'
      piece.position.equal?(Coordinate.new('A1')).should == true
    end
  end

  describe '#set_position' do
    it 'sets a new position for instance' do
      piece.set_position(Coordinate.new('A3'))
      piece.position.equal?(Coordinate.new('A3')).should == true
    end
  end

  describe '#generate_allowed_path' do
    it "generates a move using the appropriate set of rules based on a piece's type" do
      RookPathFactory.any_instance.should_receive(:generate_path)
      piece.generate_allowed_path(move)
    end
  end

  describe '#generate_path_factory' do
    it 'generates an instance of the appropriate rules object' do
      object = piece.generate_path_factory
      object.is_a?(RookPathFactory).should == true
    end
  end

  describe '#titleize' do
    it "#capitalizes the first letter of a string" do
      piece.titleize('rook').should == 'Rook'
    end
  end
end