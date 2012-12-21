Feature: Setup the board with various pieces
  In order to play a variety of games
  As a player
  I want to be able to setup the board however you want

  Scenario: 3 Rooks
    Given A new board
    When I place a rook on the board at C5
    And I place a rook on the board at C6
    And I place a rook on the board at E3
    Then I should have rooks at C5, C6, and E3

  Scenario: 3 Different Pieces
    Given A new board
    When I place a knight on the board at C5
    And I place a rook on the board at C6
    And I place a knight on the board at E3
    Then I should have a knight at C5, a rook at C6, and a knight at E3