class GameMenu
  GAME_MENU = []
  ROUND_MENU = []
  PLAYER_MENU = ["1 - Взять карту", "2 - пропустить ход", "3 - открыть карты"]
  GAME_METHODS = []
  ROUND_METHODS = []
  PLAYER_METHODS = {1 => :take_card,
                    2 => :croupier_turn,
                    3 => :reveal_cards}
  
  attr_reader :game
  
  def initialize(game)
    @game = game
    round_start
  end
  
  def round_start
    puts "#{name} твой баланс #{balance} ставка  #{BET}"
    @game.reset_game
    
  end
end