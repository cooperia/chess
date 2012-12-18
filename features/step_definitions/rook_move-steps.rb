Given /^a board$/ do
  @board = Pieces.new
  @rook = []
end

Given /^A (.*) (.*) at (.*)$/ do |color, piece, position|
  @rook.push(@board.place(piece, color, position))
end

When /^I move the (.*) from (.*) to (.*)$/ do |piece, position, destination|
  @board.move(Move.new(position, destination))
end

Then /^The (.*) (.*) is moved to (.*)$/ do |color, piece, destination|
  @board.find_at(Coordinate.new(destination))[0].should == @rook[0][0]
end
Then /^The rook at (.*) is removed$/ do |destination|
  @board.find_at(Coordinate.new(destination))[0].color.should == 'black'
end
#Then /^The move is not allowed and exception is raised$/ do
#
#  @board.move(Move.new(position, destination)).should raise_error(RuntimeError, 'Path obstructed')
#
#end

Then /^It should raise (.+?) when (.+)$/ do |exception, when_step|
  lambda {
    When when_step
  }.should raise_error(RuntimeError, exception)
end