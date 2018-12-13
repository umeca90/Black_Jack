# frozen_string_literal: true

require_relative "card"
require_relative "deck"
require_relative "base_values"
require_relative "player"
require_relative "croupier"
require_relative "validation"

class Game # rubocop:disable Metrics/ClassLength
  include BaseValues
  include Validation

  attr_accessor :player, :croupier, :deck, :player_ready, :croupier_ready

  def initialize
    @interface = GameInterface.new
    begin
      @player = create_player
    rescue StandardError
      @interface.name_error
      retry
    end
    @croupier = create_croupier
    new_game
  end

  def round_start
    loop do
      choice = @interface.player_menu
      send(choice)
    end
  end

  private

  def new_game
    reset_game
    deal_cards
    begin
      validate_balance(@player)
      validate_balance(@croupier)
      @interface.round_start
      round_start
    rescue StandardError
      @interface.selection_error
      retry
    end
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

  def croupier_takes_card
    selection = @croupier.make_choice
    @croupier_ready = true
    case selection
    when :take
      @croupier.take_card(@deck.card) if @croupier.cards.size < MAX_CARDS
    when :skip
      croupier_skip
    end
    true
  end

  def player_turn
    @player.take_card(@deck.card) if @player.cards.size < MAX_CARDS
    @interface.player_move
    croupier_turn
    game_end if game_over?
  end

  def croupier_turn
    @interface.croupier_move
    croupier_takes_card
  end

  def skip_move
    croupier_turn
  end

  def player_reveals_cards
    @player_ready = true
    croupier_takes_card unless @croupier_ready
    @interface.reveal_cards
    game_end if game_over?
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

  def game_end
    @interface.game_end
    winner
    if player_won?
      @interface.player_won
    elsif croupier_won?
      @interface.croupier_won
    else
      @interface.draw
    end
    choice = @interface.round_menu
    loop do
      send choice || exit_game
    end
  end

  def create_player
    @player = Player.new(@interface.ask_name)
    @interface.player = @player
  end

  def create_croupier
    @croupier = Croupier.new("Johny_Red_Face")
    @interface.croupier = @croupier
  end

  def exit_game
    abort("Выхожу из игры...")
  end
  # condition methods

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
    return true if @croupier_ready && (@player_ready ||
                                       @player.cards.size == MAX_CARDS)

    false
  end
end
