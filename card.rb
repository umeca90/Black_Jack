# frozen_string_literal: true

require_relative "deck"
class Card
  CARD_NAMES = %w[A K J Q] + (2..10).to_a
  SUITS = %w[♠ ♣ ♥ ♦].freeze

  attr_reader :name, :suit
  attr_accessor :value

  def initialize(name, suit, value)
    @name = name
    @suit = suit
    @value = value
  end
end
