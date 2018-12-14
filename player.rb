# frozen_string_literal: true

require_relative "deck"
require_relative "card"
require_relative "base_values"
require_relative "validation"
require_relative "hand"

class Player
  include BaseValues
  include Validation
  attr_accessor :name, :balance
  attr_reader :entity, :hand
  validate :name, :presence
  validate :name, :format, NAME_FORMAT
  def initialize(name)
    @name = name
    validate!
    @balance = START_MONEY
    @entity = :player
    @hand = Hand.new
  end

  def make_bet
    @balance -= BET if balance_valid?
  end

  def balance_valid?
    true if @balance >= 10
  end
end
