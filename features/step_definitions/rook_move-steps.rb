Given /^a board$/ do
  @board = Pieces.new
  @game = Game.new(@board)
  @rook = []
end

Given /^A (.*) (.*) at (.*)$/ do |color, piece, position|
  @rook.push(@board.place(piece, color, position))
end

When /^I move the (.*) from (.*) to (.*)$/ do |piece, position, destination|
  @game.move(position, destination)
end

Then /^The (.*) (.*) is moved to (.*)$/ do |color, piece, destination|
  @board.find_at(Coordinate.new(destination)).should == @rook[0]
end
Then /^The rook at (.*) is removed$/ do |destination|
  @board.find_at(Coordinate.new(destination)).color.should == 'black'
end

Then /^It should raise (.+?) when (.+)$/ do |exception, when_step|
  lambda {
    When when_step
  }.should raise_error(RuntimeError, exception)
end
