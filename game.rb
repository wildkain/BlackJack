require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'card.rb'
require_relative 'round.rb'
require_relative 'interface.rb'
class Game
  attr_accessor :player, :dealer, :user_cards, :dealer_cards, :deck, :interface, :round

  def initialize(params)
    @interface = params[:interface]
    @player = User.new(params[:player_name])
    @dealer = User.new('Dealer')
    @deck = Deck.new
    @player_cards = @player.hand
    @dealer_cards = @dealer.hand
  end

  def start!
    @round = Round.new(@player, @dealer, @deck, @interface)
    round.start!
    while need_new_game? && can_new_game?
      start!
    end
    abort
  end

  private

  def cancel_game
    @player.hand.clear
    @dealer.hand.clear
  end

  def need_new_game?
    begin
    interface.line
    answer = interface.new_game_answer
    case answer
    when 1
      cancel_game
      true
    when 2
      interface.goodbye
      abort
    else
      raise "Wrong answer"
    end
  rescue RuntimeError => error
    p error.message.to_s
    retry
      end
  end

  def can_new_game?
    if have_money?
      true
    else
      interface.no_money_no_honey
      abort
    end
  end

  def have_money?
    return true if @dealer.cash > 0 && @player.cash > 0
  end
end
