#TODO: Ask about cucumber file architecture... etc..
Feature: Move a knight from A to B in various states
  In order to be able to play
  As a player
  I want to be able to move a knight from A to B

Scenario: Move knight from A to B
  Given a board
  Given A black knight at A1
  When I move the knight from A1 to B3
  Then The black knight is moved to B3

Scenario: Fails to move a piece when moving path is obstructed
  Given a board
  Given A black knight at A1
  Given A white rook at A2
  When I move the knight from A1 to B3
  Then The black knight is moved to B3

Scenario: Perform a capture move
  Given a board
  Given A black knight at A1
  Given A white rook at C2
  When I move the knight from A1 to C2
  Then The rook at C2 is removed
  Then The black knight is moved to C2

Scenario: Fails to move a knight because destination is not legal for a knight
  Given a board
  Given A black knight at D4
  Then It should raise Invalid move for a knight when I move the knight from D4 to D5

  Scenario: Fails to capture a piece of the same color
    Given a board
    Given A black knight at A1
    Given A black rook at C2
    Then It should raise Can't capture your own pieces! when I move the rook from A1 to C2