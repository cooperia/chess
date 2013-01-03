class Game
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def move(origin, destination)
    Move.new(origin, destination, board).perform
  end

  def print_board
  ascii_board = ""

    (8).downto(1).each do |number|
      ascii_board += " " + number.to_s + " "
      ('A'..'H').each do |letter|
        occupant = board.find_at(Coordinate.new(letter+number.to_s))
        piece = "  "
        if occupant
          if occupant.color == 'white'
            piece = "+"
          else
            piece = "-"
          end
          piece = piece+occupant.type.chars.first.upcase
        end
        ascii_board = ascii_board + "[ " + piece + " ]"
      end
      ascii_board = ascii_board + "\n"
    end
    ascii_board += " ___  A __  B __  C __  D __  E __  F __  G __  H _\n"
    ascii_board
  end

  def print_web_board
    web_board = []
    count = 0
    (8).downto(1).each do |number|
      row = []
      web_board[count] = row
      count += 1
      ('A'..'H').each do |letter|
        occupant = board.find_at(Coordinate.new(letter + number.to_s))
        piece = ""
        if occupant
          if occupant.color == 'white'
            piece = "+"
          else
            piece = "-"
          end
          piece += occupant.type.chars.first.upcase
        end
        row = row.push(piece)
      end
    end
    web_board
  end
end