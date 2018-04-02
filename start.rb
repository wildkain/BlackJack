require_relative 'game.rb'
require_relative 'interface.rb'

interface = Interface.new
interface.welcome_message
player_name = interface.ask_name
interface.greeting(player_name)

init_params = { player_name: player_name, interface: interface }
game = Game.new(init_params)

game.start!
