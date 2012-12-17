require 'rubygems'
require 'rspec'
require '/Users/jasmina/Documents//Ruby/chess_ian/chess/chess.rb'
require 'cucumber'

describe MoveFactory do
  let(:move_factory) { MoveFactory.new() }
  let(:move) { Move.new('A1', 'A4') }

  describe '#generate_move' do
    it "generates a move using the appropriate set of rules based on a piece's type" do
      #rookrules = double("RookRules")
      #rookrules.stub(:generate_path).and_return(true)
      RookRules.any_instance.should_receive(:generate_path)
      move_factory.generate_move(move, 'rook')
    end
  end

  describe '#generate_object' do
    it 'generates an instance of the appropriate rules object' do
      object = move_factory.generate_object('rook')
      object.is_a?(RookRules).should == true
    end
  end

  describe '#titleize' do
    it "#capitalizes the first letter of a string" do
      move_factory.titleize('rook').should == 'Rook'
    end
  end
end