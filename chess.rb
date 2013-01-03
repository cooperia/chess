dir = File.dirname(__FILE__)
require dir + '/lib/game.rb'
require dir + '/lib/board.rb'
require dir + '/lib/piece.rb'
require dir + '/lib/coordinate.rb'
require dir + '/lib/move.rb'
require dir + '/lib/rook_move_generator.rb'
require dir + '/lib/rook_path_generator.rb'
require dir + '/lib/possible_moves.rb'
require dir + '/lib/path.rb'
require dir + '/lib/knight_move_generator.rb'
require dir + '/lib/knight_path_generator.rb'
require 'sinatra'

new_game = Game.new(Board.new).print_web_board

get '/new' do
  erb :board, :locals => {:greeting => new_game}
end