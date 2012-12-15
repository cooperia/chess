Given /^A Pieces object$/ do
  @pieces = Pieces.new
end

When /^I place a (.*) on the board at (.*)$/ do |type, position|
  @pieces.place(type, position)
end

Then /^I should have (.*)s at (.*), (.*), and (.*)$/ do |type, arg1, arg2, arg3|
    @pieces.collection[0][1].eql?(Coordinate.new(arg1)).should == true
    @pieces.collection[1][1].eql?(Coordinate.new(arg2)).should == true
    @pieces.collection[2][1].eql?(Coordinate.new(arg3)).should == true
    @pieces.collection.each do |piece|
      piece[0].should == type
    end
end


Then /^I should have a (.*) at (.*), a (.*) at (.*), and a (.*) at (.*)$/ do |type1, pos1, type2, pos2, type3, pos3|
  @pieces.collection[0][1].eql?(Coordinate.new(pos1)).should == true
  @pieces.collection[0][0].should == type1
  @pieces.collection[1][1].eql?(Coordinate.new(pos2)).should == true
  @pieces.collection[1][0].should == type2
  @pieces.collection[2][1].eql?(Coordinate.new(pos3)).should == true
  @pieces.collection[2][0].should == type3
end