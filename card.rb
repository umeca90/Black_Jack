# frozen_string_literal: true

require_relative "deck"
class Card
  attr_reader :name, :suit
  attr_accessor :value

  def initialize(name, suit, value)
    @name = name
    @suit = suit
    @value = value
  end
end
