require 'spec_helper'

describe RookPathGenerator do
  let(:pieces) { Board.new }
  let(:vertical_move) { Move.new('A1', 'A4', pieces) }
  let(:path_double) { double("Path Object") }

  before do
    pieces.place('rook', 'black', 'A1')
  end

  describe '#generate' do
    it 'generates a path that must be open to move a piece' do
      path = RookPathGenerator.generate(vertical_move)
      path.included?(Coordinate.new('A2')).should == true
      path.included?(Coordinate.new('A3')).should == true
      path.included?(Coordinate.new('A4')).should == false
    end
  end

  describe '#horizontal?' do
    context "when the paths size is greater than 6" do
      it "returns true" do
        path_double.stub(:size).and_return(7)
        RookPathGenerator.horizontal?(path_double).should == true
      end
    end

    context "when the paths size is less than 6" do
      it "returns false" do
        path_double.stub(:size).and_return(5)
        RookPathGenerator.horizontal?(path_double).should == false
      end
    end
  end

  describe '#cleaner' do
    it 'it calls clean on path' do
      path_double.should_receive(:clean).with('something')
      RookPathGenerator.cleaner(path_double, 'something')
    end
  end

  describe '#arranger' do
    it 'return an array of position and destination' do
      vertical_move.stub(:origin).and_return(Coordinate.new("A1"))
      vertical_move.stub(:destination).and_return(Coordinate.new("A5"))
      RookPathGenerator.arranger(vertical_move).should == ["A1", "A5"]
    end

    it "is sorted" do
      vertical_move.stub(:origin).and_return(Coordinate.new("A5"))
      vertical_move.stub(:destination).and_return(Coordinate.new("A1"))
      RookPathGenerator.arranger(vertical_move).should == ["A1", "A5"]
    end
  end
end
