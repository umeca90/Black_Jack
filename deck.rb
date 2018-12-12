# frozen_string_literal: true

require_relative "card"

class Deck
  attr_accessor :full_deck, :value
  CARD_NAMES = %w[A K J Q] + (2..10).to_a
  SUITS = ["♠", "♣", "♥", "♦"].freeze
  def initialize
    @full_deck = []
    cards_hash = {}
    CARD_NAMES.each { |name| cards_hash[name] = define_card_value(name.to_s) }
    cards_hash.each do |name, value|
      SUITS.each { |suit| @full_deck << Card.new(name.to_s, suit, value.to_i) }
    end
    shuffle
  end

  def shuffle
    @full_deck.shuffle!
  end

  def define_card_value(card)
    case card
    when /\d/ then card.to_i
    when /[^0-9A]/ then 10
    else
      1
    end
  end

  def card
    card = @full_deck.sample
    @full_deck.delete(card)
    card
  end
end
