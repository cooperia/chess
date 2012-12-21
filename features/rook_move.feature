Feature: Move a rook from A to B in various states
  In order to be able to play
  As a player
  I want to be able to move a rook from A to B

Scenario: Move rook from A to B
  Given A new board
  And A black rook at A1
  When I move the rook from A1 to B1
  Then The black rook is at B1

Scenario: Perform a capture move
  Given A new board
  And A black rook at A1
  And A white rook at C1
  When I move the rook from A1 to C1
  Then The rook at C1 is removed from the board
  And The black rook is at C1

Scenario: Fails to move a piece when moving path is obstructed
  Given A new board
  And A black rook at A1
  And A white rook at C1
  Then It should raise 'Path obstructed' when I move the rook from A1 to D1

Scenario: Fails to move a rook because destination is not legal for a rook
  Given A new board
  And A black rook at A1
  Then It should raise 'Invalid move for a rook' when I move the rook from A1 to D5

Scenario: Fails to move a piece because destination is not on the board
  Given A new board
  And A black rook at A1
  Then It should raise 'Invalid Coordinates' when I move the rook from A1 to Z1

Scenario: Fails to capture a piece of the same color
  Given A new board
  And A black rook at A1
  And A black rook at C1
  Then It should raise 'Can't capture your own pieces!' when I move the rook from A1 to C1

Scenario: Fails to move a piece because there is no piece at position
  Given A new board
  And A black rook at A1
  Then It should raise 'No piece at position' when I move the rook from C1 to D1


