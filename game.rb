class Game
  
#Раздает по 2 случ карты, показывает юзеру сумму своих очков
#Забирает по 10 баксов и кладет в банк
#Отдает ход пользователю
   attr_accessor :bank, :player, :croupier, :deck

   def initialize(player, croupier)
     @player = player
     @croupier = croupier
     @deck = Deck.new
     @bank = 0
   end
   
   def start_game
      @player.make_bet
      @croupier.make_bet
      @bank += BET * 2
   end
   
   def deal_cards(card)
     2.times do
        @player.take_card(@deck.card)
        @croupier.take_card(@deck.card)
     end
   end
   
   def reset_game()
     @deck = Deck.new
     @palyer.reset_cards
     @croupier.reset_cards
     
   end
   

   
   def take_bet
     @player.balance -= 10
     @croupier.balance -= 10
     @bank += 20
   end
end