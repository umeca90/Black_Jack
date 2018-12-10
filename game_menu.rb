class GameMenu
  GAME_MENU = []
  ROUND_MENU = []
  PLAYER_MENU = []
  GAME_METHODS = []
  ROUND_METHODS = []
  PLAYER_METHODS = []
  
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