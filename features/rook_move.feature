Feature: Move a rook from A to B with no obstructions or captures
  In order to be able to play
  As a player
  I want to be able to move a rook from A to B

Scenario: Move rook from A to B
  Given A Rook at A1
  When I move the rook to B1
  Then The rook is moved to B1