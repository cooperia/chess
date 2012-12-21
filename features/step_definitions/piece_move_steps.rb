Given /^A new board$/ do
  @board = Board.new
  @game = Game.new(@board)
  @rook = []
end

Given /^A (.*) (.*) at (.*)$/ do |color, piece, position|
  @rook.push(@board.place(piece, color, position))
end

When /^I move the (.*) from (.*) to (.*)$/ do |piece, position, destination|
  @game.move(position, destination)
end

Then /^The (.*) (.*) is at (.*)$/ do |color, piece, destination|
  @board.find_at(Coordinate.new(destination)).should == @rook[0]
end
Then /^The rook at (.*) is removed from the board$/ do |destination|
  @board.find_at(Coordinate.new(destination)).color.should == 'black'
end

Then /^It should raise '(.+?)' when (.+)$/ do |exception, when_step|
  lambda {
    step when_step
  }.should raise_error(RuntimeError, exception)
end
