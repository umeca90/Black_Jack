# frozen_string_literal: true

require_relative "player"

class Croupier < Player
  include Validation

  VALUE_TO_REACH = 17

  validate :name, :presence
  validate :name, :format, NAME_FORMAT
  def initialize(name)
    super
    @entity = :croupier
  end

  def make_choice
    @hand.score < VALUE_TO_REACH ? :take : :skip
  end
end
