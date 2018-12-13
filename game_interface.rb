# frozen_string_literal: true

require_relative "card"
require_relative "deck"
require_relative "base_values"
require_relative "player"
require_relative "croupier"
require_relative "game"
require_relative "validation"

class GameInterface
  include BaseValues
  include Validation

  ROUND_MENU = ["1 - сыграть еще, 2 - выход"].freeze
  PLAYER_MENU = ["1 - Взять карту",
                 "2 - пропустить ход",
                 "3 - открыть карты",
                 "4 - остановить игру"].freeze
  ROUND_METHODS = { 1 => :new_game,
                    2 => :exit_game }.freeze
  PLAYER_METHODS = { 1 => :player_turn,
                     2 => :skip_move,
                     3 => :player_reveals_cards,
                     4 => :exit_game }.freeze

  attr_accessor :croupier, :player

  def round_start
    puts "#{@player.name}, твой баланс #{@player.balance} ставка  #{BET}"
    puts "Раздаём карты...."
  end

  def ask_name
    puts "Введите Ваше имя"
    gets.chomp.to_s
  end

  def round_menu
    puts ROUND_MENU
    choice = gets.chomp.to_i

    ROUND_METHODS[choice]
  end

  def player_menu
    puts "Ваши карты #{player_cards}"
    puts "Ваш ход"
    puts PLAYER_MENU
    choice = gets.chomp.to_i

    PLAYER_METHODS[choice] # || break
  end

  def player_move
    puts "Крупье выдал случайную карту"
    puts "#{@player.cards.last.name}_#{@player.cards.last.suit}"
  end

  def croupier_move
    puts "------------------------------------------"
    puts "Ход крупье"
    puts "------------------------------------------"
  end

  def reveal_cards
    puts "Вы решили раскыть карты"
  end

  def game_end
    puts "Подсчет очков"
    puts "Ваши карты #{@player.show_cards}",
         "очки #{@player.cards_sum}"
    puts "Карты крупье #{@croupier.show_cards}",
         "очки #{@croupier.cards_sum}"
  end

  def player_won
    puts "Выигрыш #{BET}, баланс #{@player.balance}"
  end

  def croupier_won
    puts "Выграл крупье, ставка #{BET},Ваш баланс #{@player.balance}"
  end

  def draw
    puts "Боевая ничья, Ваш баланс #{@player.balance}"
  end

  def player_cards
    @player.show_cards
  end

  def croupier_cards
    @croupier_ready ? @croupier.show_cards : MASK
  end

  def name_error
    puts "Ошибка ввода имени"
  end

  def selection_error
    puts "Ошибка ввода"
  end

  def croupier_skip
    puts "Пропускаю ход"
  end
end
