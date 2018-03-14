# Main class with game operations.
require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'card.rb'


class Game

  attr_accessor :user, :user_cards, :dealer_cards

  def initialize
    p "Welcome to game! What is your name"
    username = gets.chomp
    @user = User.new(username)
    @dealer = User.new("Dealer")
    p "Starting new game for Users: #{@user.name} and #{@dealer.name}"
    @user_cards = @user.hand
    @dealer_cards = @dealer.hand
    start_game
  end

  def start_game
    p "Now we create deck for you and shuffle."
    @deck = Deck.new
    first_take(@user)
    first_take(@dealer)
    if  calculate_cards!(@user) > calculate_cards!(@dealer)
      p "You are win! Your score: #{calculate_cards!(@user)} Dealer score:#{calculate_cards!(@dealer)}"
    else
      p "Dealer win! Your score: #{calculate_cards!(@user)} Dealer score:#{calculate_cards!(@dealer)}"
    end
  end


  def first_take(user)
    2.times do
      card = @deck.cards.slice!(0)
      user.hand << card
    end
  end

  def calculate_cards!(user)
    value = 0
    user.hand.each do |card|
      value += card.value
    end
    value
  end


end

