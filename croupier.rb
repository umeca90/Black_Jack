# frozen_string_literal: true

require_relative "validation"
class Croupier < Player
  include Validation

  validate :name, :presence
  validate :name, :format, NAME_FORMAT
  def initialize(name)
    super
    @entity = :croupier
  end

  def make_choice
    @cards_sum < VALUE_TO_REACH ? :take : :skip
  end
end
