# frozen_string_literal: true

require_relative "card"

class Deck
  attr_accessor :deck, :value

  def initialize
    @deck = []
    cards = {}
    Card::CARD_NAMES.each { |name| cards[name] = define_card_value(name.to_s) }
    cards.each do |name, value|
      Card::SUITS.each { |suit| @deck << Card.new(name.to_s, suit, value.to_i) }
    end
    shuffle
  end

  def shuffle
    @deck.shuffle!
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
    card = @deck.sample
    @deck.delete(card)
    card
  end
end
