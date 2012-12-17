Given /^A Rook at A1$/ do
  @board = Pieces.new
  @rook = @board.place('rook', 'black', 'A1')
end
When /^I move the rook to B1$/ do
  @board.move(Move.new('A1', 'B1'))
end
Then /^The rook is moved to B1$/ do
  @board.find_at(Coordinate.new('B1'))[0].should == @rook[0]
end