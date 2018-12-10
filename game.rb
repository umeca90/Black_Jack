class Game
  
#Раздает по 2 случ карты, показывает юзеру сумму своих очков
#Забирает по 10 баксов и кладет в банк
#Отдает ход пользователю
   attr_accessor :player, :croupier, :deck, :player_ready, :croupier_ready

   def initialize(player, croupier)
     @player = player
     @croupier = croupier
     start_game
   end
   
   def start_game
      enough_money?
      reset_game
      @player.make_bet
      @croupier.make_bet
      @bank += BET * 2
      deal_cards
   end
   
   def deal_cards
     2.times do
        @player.take_card(@deck.card)
        @croupier.take_card(@deck.card)
     end
   end
   
   def reset_game()
     @deck = Deck.new
     @player.reset_cards
     @croupier.reset_cards
     
   end
   

   
   
   #condition methods
   
   def player_won?
      
   end
   
   def croupier_won?
   end
   
   def enough_money?
      
   end
   
   def game_over?
   end
end