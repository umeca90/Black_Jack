# frozen_string_literal: true

require_relative "card"
require_relative "deck"
require_relative "base_values"
require_relative "player"
require_relative "croupier"
require_relative "game"
require_relative "game_interface"
require_relative "validation"

class Main
  puts "Welcome, wanna make some money?"
  puts "Введите Ваше имя"
  begin
    name = gets.chomp.to_s.capitalize
    player = Player.new(name)
    croupier = Croupier.new("Cotton_Eye_Joe")
  rescue StandardError => e
    puts e.to_s
    retry
  end
  game = Game.new(player, croupier)

  GameInterface.new(game)
end
