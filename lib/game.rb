class Game
  attr_reader :pieces

  def initialize(pieces)
    @pieces = pieces
  end

  def move(position, destination)
    Move.new(position, destination).move(pieces)
  end

  def place_piece(type, color, position)
    pieces.place(type, color, position)
    #puts "#{color} #{type} placed at #{position}"
  end

  def destroy_piece(position)
    pieces.destroy_piece(position)
  end

  def reset_board
    @pieces = Pieces.new
  end

  #def getter
  #  puts 'Please enter a command'
  #  message = gets().chomp()
  #  sender(message)
  #end
  #
  #def sender(message)
  #  if message == 'place_piece'
  #    puts 'Enter a type (rook)'
  #    type = gets().chomp()
  #    puts 'Enter a color (black or white)'
  #    color = gets().chomp()
  #    puts 'Enter a position (A1-H8)'
  #    position = gets().chomp()
  #    send("#{message}", type, color, position)
  #  elsif message == 'move'
  #    puts 'Enter position you want to move from'
  #    position = gets().chomp()
  #    puts 'Enter destination you want to move to'
  #    destination = gets().chomp()
  #    send("#{message}", position, destination)
  #  end
  #end
end