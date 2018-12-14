# frozen_string_literal: true

require_relative "card"
require_relative "deck"
require_relative "base_values"
require_relative "player"
require_relative "croupier"
require_relative "validation"
require_relative "hand"

class Game # rubocop:disable Metrics/ClassLength
  include BaseValues
  include Validation

  attr_accessor :player, :croupier, :deck, :player_ready, :croupier_ready

  def initialize
    @interface = GameInterface.new
    begin
      @player = create_player
    rescue StandardError => err
      @interface.name_error(err)
      retry
    end
    @croupier = create_croupier
    @interface.welcome
  end

  def main_menu
    loop do
      choice = @interface.main_menu
      case choice
      when "1" then new_game
      else exit_game
      end
    end
  end

  private

  def new_game
    return @interface.player_error unless @player.balance_valid?
    return @interface.croupier_error unless @croupier.balance_valid?

    reset_game
    deal_cards
    @player.make_bet
    @croupier.make_bet
    player_menu
  end

  def player_menu
    loop do
      break if game_over?

      @interface.player_info
      @interface.croupier_info
      choice = @interface.player_menu
      case choice
      when "1" then player_turn
      when "2" then skip_move
      when "3" then reveal_cards
      else break
      end
    end
  end

  def reset_game
    @deck = Deck.new
    @player.hand.reset_cards
    @croupier.hand.reset_cards
    @player_ready = false
    @croupier_ready = false
    @interface.round_start
  end

  def deal_cards
    2.times do
      @player.hand.take_card(@deck.card)
      @croupier.hand.take_card(@deck.card)
    end
  end

  def player_turn
    @player.hand.take_card(@deck.card) if @player.hand.cards.size < MAX_CARDS
    @interface.player_move
    croupier_turn
    game_end if game_over?
  end

  def croupier_turn
    @interface.croupier_move
    selection = @croupier.make_choice
    @croupier_ready = true
    case selection
    when :take
      @croupier.hand.take_card(@deck.card) if
      @croupier.hand.cards.size < MAX_CARDS
    when :skip
      @interface.croupier_skip
    end
    # true
  end

  def skip_move
    croupier_turn
  end

  def reveal_cards
    @player_ready = true
    @croupier_ready = true
    @interface.reveal_cards
    game_end if game_over?
  end

  def winner
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
    true
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
    true if @player.hand.score > @croupier.hand.score && !lost?(@player) ||
            @player.hand.score < @croupier.hand.score && lost?(@croupier) &&
            !lost?(@player)
  end

  def croupier_won?
    true if @croupier.hand.score > @player.hand.score && !lost?(@croupier) ||
            @croupier.hand.score < @player.hand.score && lost?(@player) &&
            !lost?(@croupier)
  end

  def game_over?
    return true if @croupier_ready && (@player_ready ||
                                       @player.hand.cards.size == MAX_CARDS)

    false
  end

  def lost?(player)
    true if player.hand.score > BLACK_JACK
  end
end
