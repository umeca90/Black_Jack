# frozen_string_literal: true

require_relative "card"
require_relative "deck"
require_relative "base_values"
require_relative "player"
require_relative "croupier"
require_relative "validation"

class Game
  include BaseValues
  include Validation

  attr_accessor :player, :croupier, :deck, :player_ready, :croupier_ready

  def initialize(player, croupier)
    @player = player
    @croupier = croupier
    start_game
  end

  def start_game
    enough_money?
    reset_game
    deal_cards
  end

  def deal_cards
    2.times do
      @player.take_card(@deck.card)
      @croupier.take_card(@deck.card)
    end
  end

  def reset_game
    @deck = Deck.new
    @player.reset_cards
    @croupier.reset_cards
    @player_ready = false
    @croupier_ready = false
  end

  def player_takes_card
    @player.take_card(@deck.card) unless @player.cards.size > MAX_CARDS
  end

  def croupier_takes_card
    @croupier_ready = true
    selection = @croupier.make_choice
    case selection
    when :take
      puts "Беру карту"
      puts "------------------------------------------"
      @croupier.take_card(@deck.card) unless @croupier.cards.size > MAX_CARDS
    when :skip
      puts "Пропускаю ход"
      puts "------------------------------------------"
    end
  end

  def player_cards
    @player.show_cards
  end

  def croupier_cards
    @croupier_ready ? @croupier.show_cards : MASK
  end

  def skip_move
    croupier_takes_card
  end

  def player_reveals_cards
    @player_ready = true
    croupier_takes_card unless @croupier_ready
  end

  # condition methods

  def enough_money?
    raise "У Вас мало денег" unless @player.balance_valid?
    raise "У крупье мало денег" unless @croupier.balance_valid?

    true
  end

  def player_won?
    true if @player.cards_sum > @croupier.cards_sum && !@player.lost? ||
            @player.cards_sum < @croupier.cards_sum && @croupier.lost? &&
            !@player.lost?
  end

  def croupier_won?
    true if @croupier.cards_sum > @player.cards_sum && !@croupier.lost? ||
            @croupier.cards_sum < @player.cards_sum && @player.lost? &&
            !@croupier.lost?
  end

  def game_over?
    return true if @croupier_ready && (@player_ready || @player.cards.size == MAX_CARDS)

    false
  end

  def winner
    @player.make_bet
    @croupier.make_bet
    if player_won?
      @player.balance += BET * 2
    elsif croupier_won?
      @croupier.balance += BET * 2
    else
      @player.balance += BET
      @croupier.balance += BET
    end
  end
end
