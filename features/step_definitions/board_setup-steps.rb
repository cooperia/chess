Given /^A Pieces object$/ do
  @pieces = Pieces.new
end

When /^I place a (.*) on the board at (.*)$/ do |type, position|
  @pieces.place(type, 'black', position)
end

Then /^I should have (.*)s at (.*), (.*), and (.*)$/ do |type, arg1, arg2, arg3|
    @pieces.collection[0].position.equal?(Coordinate.new(arg1)).should == true
    @pieces.collection[1].position.equal?(Coordinate.new(arg2)).should == true
    @pieces.collection[2].position.equal?(Coordinate.new(arg3)).should == true
    @pieces.collection.each do |piece|
      piece.type.should == type
    end
end


Then /^I should have a (.*) at (.*), a (.*) at (.*), and a (.*) at (.*)$/ do |type1, pos1, type2, pos2, type3, pos3|
  @pieces.collection[0].position.equal?(Coordinate.new(pos1)).should == true
  @pieces.collection[0].type.should == type1
  @pieces.collection[1].position.equal?(Coordinate.new(pos2)).should == true
  @pieces.collection[1].type.should == type2
  @pieces.collection[2].position.equal?(Coordinate.new(pos3)).should == true
  @pieces.collection[2].type.should == type3
end