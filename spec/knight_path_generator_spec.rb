require 'spec_helper'

describe KnightPathGenerator do
  describe '#generate' do
    it 'returns an empty path object' do
      KnightPathGenerator.generate(Move.new('A1', 'B1', Pieces.new)).is_a?(Path).should == true
    end
  end

end