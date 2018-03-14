# Main class with game operations.
require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'card.rb'


class Game

  attr_accessor :player, :dealer, :user_cards, :dealer_cards

  def initialize
    p "Welcome to game! What is your name"
    username = gets.chomp
    @player = User.new(username)
    @dealer = User.new("Dealer")
    p "Starting new game for Users: #{@player.name} and #{@dealer.name}"
    @player_cards = @player.hand
    @dealer_cards = @dealer.hand
    start_game
  end

  def get_action
    p "What you to do? Enter |'1' - Hit!|, |'2' - Stand|, |'3' - cards on table|"
    action = gets.chomp.to_i
    case action
      when 1 then player_hit
      when 2 then dealer_hit
      when 3 then show_cards
      else
        abort
    end
    player_win? ? win(@player) : win(@dealer)
  end

  def win(user)
    p "#{user.name} WIN! Scores: #{user.scores}"
  end


  def player_hit
    take_card(@player)
  end

  def dealer_hit
    take_card(@dealer)
  end

  def start_game
    p "Now we create deck for you and shuffle."
    @deck = Deck.new
    2.times do
      take_card(@player)
      take_card(@dealer)
    end
    show_cards
    p "You: #{@player.scores}  = = = Dealer: #{@dealer.scores}"
    until have_winner?
      get_action
    end
  end


  def take_card(user)
    raise RuntimeError, "Cant take card if you have more than 2" if user.hand.size > 2
    card = @deck.cards.slice!(0)
    user.hand << card
    user.calculate_cards!
  end

  def have_winner?
    return true if (player_win? || player_lose?) && (@player.hand.size > 2)
    false
  end

  def player_win?
    @player.scores > @dealer.scores && @player.scores <= 21
  end

  def player_lose?
  !player_win?
  end

  def show_scores
    p "You scores: #{@player.scores}|| Dealer scores: #{@dealer.scores}"
  end

  def show_cards
    [@player, @dealer].each do |user|
      p "#{user.name} cards:"
      user.hand.each {|card| print "|#{card.rank} #{card.suit}| \n"}
    end
  end

end

