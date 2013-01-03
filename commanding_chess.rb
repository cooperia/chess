#!/usr/bin/env ruby

dir = File.dirname(__FILE__)
require dir + '/chess.rb'

game = Game.new(Board.new)
STDOUT.print(game.print_board)
