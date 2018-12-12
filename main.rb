require_relative "card"
require_relative "deck"
require_relative "base_values"
require_relative "player"
require_relative "croupier"
require_relative "game"
require_relative "game_interface"

puts "Welcome, enter ur name"
name = gets.chomp.to_s
player = Player.new(name)
croupier = Croupier.new("Cotton Eye Joe")
game = Game.new(player, croupier)

GameInterface.new(game)

