require 'spec_helper'

describe 'Coordinate' do
  let(:position) {Coordinate.new('A1')}

  describe '#legal?' do
    it 'should return true for valid coordinates' do
      position.legal?.should == true
    end
  end

  describe '#equal?' do
    it 'should return true for equal coordinate values' do
      position2 = Coordinate.new('A1')
      position.equal?(position2).should == true
    end
  end

  describe '#stringify' do
    it 'should turn a coordinate object into a string' do
      position.stringify.should == 'A1'
    end
  end
end