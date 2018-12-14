# frozen_string_literal: true

# require_relative "card"
# require_relative "deck"
# require_relative "base_values"
require_relative "player"

# require_relative "validation"
# require_relative "hand"
class Croupier < Player
  include Validation
  include BaseValues

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
