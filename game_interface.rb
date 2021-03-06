# frozen_string_literal: true

require_relative "card"
require_relative "deck"
require_relative "player"
require_relative "croupier"
require_relative "game"
require_relative "validation"
require_relative "hand"

class GameInterface
  include Validation
  MASK = "######"
  DELIMITER = "------------------------------------------"
  ROUND_MENU = ["1 - Новая игра , 2 или прочий символ выход - выход"].freeze
  PLAYER_MENU = ["1 - Взять карту",
                 "2 - пропустить ход",
                 "3 - открыть карты",
                 "Прочий ввод - остановить игру"].freeze

  attr_accessor :croupier, :player

  def welcome
    puts "Привет! #{@player.name}, давай сыграем в Black Jack"
  end

  def main_menu
    puts ROUND_MENU
    gets.chomp.to_s
  end

  def player_info
    print "#{@player.name}, твой баланс #{@player.balance} ставка  #{Game::BET}"
  end

  def croupier_info
    puts " || баланс крупье #{@croupier.balance}"
  end

  def round_start
    puts DELIMITER
    puts "Начинаем игру"
    puts "Раздаю карты...."
    puts DELIMITER
  end

  def ask_name
    puts "Введите Ваше имя"
    gets.chomp.to_s
  end

  def player_menu
    puts "Ваши карты #{player_cards}, сумма очков #{@player.hand.score}"
    puts DELIMITER
    puts "Карты крупье #{croupier_cards}"
    puts "Ваш ход"
    puts PLAYER_MENU
    gets.chomp.to_s
  end

  def player_move
    puts "Крупье выдал случайную карту"
    puts "#{@player.hand.cards.last.name}_#{@player.hand.cards.last.suit}"
  end

  def croupier_move
    puts DELIMITER
    puts "Ход крупье"
    puts DELIMITER
  end

  def reveal_cards
    puts "Вы решили раскыть карты"
  end

  def game_end
    puts "Подсчет очков"
    puts "Ваши карты #{@player.hand.show_cards}",
         "очки #{@player.hand.score}"
    puts "Карты крупье #{@croupier.hand.show_cards}",
         "очки #{@croupier.hand.score}"
  end

  def player_won
    puts "Вы выиграли!"
    puts "Выигрыш #{Game::BET}, баланс #{@player.balance}"
  end

  def croupier_won
    puts "Вы проиграли..."
    puts "Выиграл крупье, ставка #{Game::BET},Ваш баланс #{@player.balance}"
  end

  def draw
    puts "Боевая ничья, Ваш баланс #{@player.balance}"
  end

  def player_cards
    @player.hand.show_cards
  end

  def croupier_cards
    @croupier_ready ? @croupier.hand.show_cards : MASK
  end

  def name_error(err)
    puts "Ошибка ввода имени  #{err}"
  end

  def selection_error(err)
    puts "Ошибка ввода #{err}"
  end

  def player_error
    puts "Ваш баланс = #{@player.balance}, невозможно продолжить"
  end

  def croupier_error
    puts "Баланс крупье = #{@croupier.balance}, невозможно продолжить"
  end

  def croupier_skip
    puts DELIMITER
    puts "Пропускаю ход"
    puts DELIMITER
  end
end
