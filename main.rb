# frozen_string_literal: true

# require "tracer"
require_relative "hand"
require_relative "card"
require_relative "deck"
require_relative "player"
require_relative "croupier"
require_relative "game"
require_relative "game_interface"
require_relative "validation"
require_relative "hand"

# trace = TracePoint.new(:call) do |tp|
# p [tp.path, tp.method_id]
# end
# trace.enable
game = Game.new
game.main_menu

# Thread.current.backtrace
# Tracer.off
