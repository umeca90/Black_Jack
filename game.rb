class Game
  
#Раздает по 2 случ карты, показывает юзеру сумму своих очков
#Забирает по 10 баксов и кладет в банк
#Отдает ход пользователю
   attr_accessor :bank, :player, :diller, :deck
   
   MOVES = { 1 => :ask_card,
             2 => :skip_move,
             3 => :reveal_cards }
             
   
   def initialize()
     @bank = 0
   end
   
   def reset_game()
     @deck = Deck.new
     @bank = 0
   end
   
   def start_game
     puts "welcome, enter ur name"
     name = gets.chomp.to_s
     @player = Player.new(name)
     @diller = Diller.new
     
   end
   
   def give_card(card)
     2.times do
        @player.current_cards << @deck.card
        @diller.current_cards << @deck.card
     end
   end
   
   def take_bet
     @player.balance -= 10
     @diller.balance -= 10
     @bank += 20
   end
end