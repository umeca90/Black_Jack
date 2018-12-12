require_relative "card"
require_relative "deck"
require_relative "base_values"
require_relative "player"
require_relative "croupier"
require_relative "game"

class GameInterface
  include BaseValues
  ROUND_MENU = ["1 - сыграть еще, 2 - выход"]
  PLAYER_MENU = ["1 - Взять карту", "2 - пропустить ход", "3 - открыть карты"]
  ROUND_METHODS = {1 => :start_game }
  PLAYER_METHODS = {1 => :player_move,
                    2 => :croupier_move,
                    3 => :reveal_cards }
  
  attr_reader :game
  
  def initialize(game)
    @game = game
    round_start
  end
  
  def round_start
    puts "#{@game.player.name} твой баланс #{@game.player.balance} ставка  #{BET}"
    @game.start_game
    puts "Раздаём карты...."
    puts "У вас #{@game.player_cards}",
         "у крупье #{@game.croupier_cards}"
    player_menu
  rescue Exception => e
    puts "#{e}.inspect"
  end
  
  
  def round_menu
    puts ROUND_MENU
    choice = gets.chomp.to_i
    send ROUND_METHODS[choice] || abort
  end
  
  
  def player_menu
    loop do
     puts "Ваш ход"
     puts PLAYER_MENU
     choice = gets.chomp.to_i
     send PLAYER_METHODS[choice] || break
    end
  end
    
  def player_move
    puts "Крупье выдаёт случайную карту"
    @game.player_takes_card
    puts "#{@game.player.cards.last}"
    puts "Ваши карты #{@game.player.show_cards}"
    puts "Ваши очки #{@game.player.cards_sum}"
    croupier_move
  end
  
  def croupier_move
    puts "Ход крупье"
    @game.croupier_takes_card
  end
  
  def reveal_cards
    @game.player_reveals_cards
    game_end if @game.game_over?
  end
  
  def game_end
    puts  "Подсчет очков"
    puts "Ваши карты #{@game.player.show_cards}", 
                "очки #{@game.player.cards_sum}"
    puts "Карты крупье #{@game.croupier.show_cards}",
                  "очки #{@game.croupier.cards_sum}"
    @game.winner
      if @game.player_won?
        puts "Выигрыш #{BET}, баланс#{@game.player.balance}"
      elsif @game.croupier_won?
        puts "Выграл крупье, ставка #{BET},Ваш баланс#{@game.player.balance}"
      else 
        puts "Боевая ничья, Ваш баланс#{@game.player.balance}"
      end
      round_menu
  end

  




end