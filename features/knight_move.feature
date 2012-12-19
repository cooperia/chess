Feature: Move a knight from A to B in various states
  In order to be able to play
  As a player
  I want to be able to move a knight from A to B

Scenario: Move knight from A to B
  Given a board
  Given A black knight at A1
  When I move the knight from A1 to B3
  Then The black knight is moved to B3