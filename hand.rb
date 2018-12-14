# frozen_string_literal: true

require_relative "card"
require_relative "deck"
require_relative "base_values"
require_relative "player"
require_relative "croupier"
require_relative "game"
require_relative "game_interface"
require_relative "validation"

class Hand
  include BaseValues
  include Validation

  attr_reader :cards, :score

  def initialize
    @cards = []
    @score = 0
  end

  def score_sum
    @cards.last.value = 11 if @cards.last.name == "A" &&
                              @score + 11 <= BLACK_JACK
    @score += @cards.last.value
  end

  def take_card(card)
    @cards << card
    score_sum
  end

  def show_cards
    cards = []
    @cards.each { |card| cards << "#{card.name}#{card.suit}" }
    "#{cards.join(' |')} "
  end

  def reset_cards
    @cards = []
    @score = 0
  end
end
