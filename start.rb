require_relative 'game.rb'

p '________________________________________'
p 'Welcome to BLACKJACK! What is your name?'
player_name = gets.chomp.capitalize
params = { player_name: player_name }
game = Game.new(params)
p "Starting new game for Users: #{player_name} and Dealer"
p '______________________________________________________'
game.start
