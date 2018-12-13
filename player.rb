# frozen_string_literal: true

require_relative "deck"
require_relative "card"
require_relative "base_values"
require_relative "validation"
class Player
  include BaseValues
  include Validation
  attr_accessor :cards, :name, :cards_sum, :balance
  attr_reader :entity
  validate :name, :presence
  validate :name, :format, NAME_FORMAT
  def initialize(name)
    @name = name
    validate!
    @balance = START_MONEY
    @cards = []
    @cards_sum = 0
    @entity = :player
  end

  def reset_cards
    @cards = []
    @cards_sum = 0
  end

  def make_bet
    @balance -= BET if balance_valid?
  end

  def count_card_sum
    @cards.last.value = 11 if @cards.last.name == "A" &&
                              @cards_sum + 11 <= BLACK_JACK
    @cards_sum += @cards.last.value
  end

  def take_card(card)
    @cards << card
    count_card_sum
  end

  def show_cards
    cards = []
    @cards.each { |card| cards << "#{card.name}#{card.suit}" }
    "#{cards.join(' ,')} || сумма - #{@cards_sum}"
  end

  def balance_valid?
    true if @balance >= 10
  end

  def lost?
    true if @cards_sum > BLACK_JACK
  end
end
