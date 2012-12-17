Feature: Move a rook from A to B with no obstructions or captures
  In order to be able to play
  As a player
  I want to be able to move a rook from A to B

Scenario: Move rook from A to B
  Given a board
  Given A black rook at A1
  When I move the rook from A1 to B1
  Then The black rook is moved to B1

Scenario: Perform a capture move
  Given a board
  Given A black rook at A1
  Given A white rook at C1
  When I move the rook from A1 to C1
  Then The rook at C1 is removed
  Then The black rook is moved to C1
