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