require_relative "deck"
require_relative "card"
require_relative "base_values"

class Player
  #Пользователь
  #Запрашивается имя, начинается игра
  #В банке есть 100 баксов
  #Получает 2 рандомные карты, которые он видит
  #Видит сумму своих карт
  #Раздача - делается ставка в банк
  #После раздачи ход пользователя:
    #1-skip, ход переходит к дилеру
    #2-add_card только если у пользователя == 2 карты, добав случ карта,
                                                       #пересчет очков
                                                       #только 1 карта добавл
  #3-reveal_cards - открываются карты дилера и игрока, видна сумма, подсчет рез.
  #ход дилера
  #Игрок может : пропустить ход, проиграть, выиграть, открыть карты,получить 2 карты, взять еще 1 доп, если 3 то автоматически идет подсчет,
  include BaseValues
  attr_accessor :cards, :name, :cards_sum, :balance
  attr_reader 
  def initialize(name)
    @name = name
    @balance = START_MONEY
    @cards = []
    @cards_sum = 0
  end
  
  def reset_cards
    @cards = []
    @cards_sum = 0
  end
  
  def make_bet
    raise "Одежда не принимаются, Ваш баланс #{@balace}" unless balance_valid?
    @balance -= BET
  end  
  
  #def count_cards_sum
    #ace = false
    #@cards.each do |card|
      #@cards_sum += card.value
      #ace = true if card.name == "A"
    #end
    #@cards_sum += 10 if ace && @cards_sum >= BLACK_JACK
    #@cards_sum
  #end

  def count_card_sum
    @cards.last.value = 11 if @cards.last.name == "A" &&
                              @cards_sum + 11 <= BLACK_JACK
    @cards_sum += @cards.last.value    
  end

  def take_card(card)
    @cards << card 
    count_card_sum
  end
  
  def show_cards
    cards = []
    @cards.each { |card| cards << "#{card.name}#{card.suit}" }
    puts cards, "#{@cards_sum}"
  end
  
  def balance_valid?
    @balance > 0
  end
  
  def lost?
    true if @cards_sum > BLACK_JACK
  end
  


  
end