puts "Welcome, enter ur name"
name = gets.chomp.to_s
player = Player.new(name)
croupier = Croupier.new("Cotton Eye Joe")
game = Game.new(player, croupier)
