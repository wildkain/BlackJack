# Main class with game operations.
require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'card.rb'

class Game
  attr_accessor :player, :dealer, :user_cards, :dealer_cards, :bank, :deck

  def initialize(params)
    @player = User.new(params[:player_name])
    @dealer = User.new('Dealer')
    @player_cards = @player.hand
    @dealer_cards = @dealer.hand
    @bank = 0
  end

  def start
    p 'Now we create deck for you and shuffle.'
    @deck = Deck.new
    2.times do
      take_card(@player)
      take_card(@dealer)
    end
    make_beats(10)
    show_dealer_cards_size
    line
    show_cards(@player)
    p "Your scores: #{@player.scores} Your cash: #{@player.cash}"
    line
    take_action
  end

  def take_action
    p "What you to do? Enter |'1' - Hit!|, |'2' - Stand|, |'3' - show cards|"
    action = gets.chomp.to_i
    case action
    when 1 then player_hit
    when 2 then stand
    when 3 then show_cards(true)
    else
      abort
    end
    show_winner
    new_game
  end

  def win(user)
    p "#{user.name} WIN! Scores: #{user.scores}"
  end

  def player_hit
    take_card(@player)
    p "You are take card #{@player_cards[2].show}"
    dealer_hit
  end

  def stand
    if @dealer_cards.size < 3 && @dealer.scores <= 17
      dealer_hit
    else
      show_cards(@dealer)
      line
      show_cards(@player)
    end
  end

  def dealer_hit
    return if @dealer.scores >= 17
    take_card(@dealer)
    p "Dealer taken card #{@dealer_cards[2].show}"
    show_cards(@dealer)
  end

  def show_winner
    win = who_win?
    if win.is_a?(User)
      win.winning(@bank)
      p "#{win.name}  WIN!!! Scores: #{win.scores} Cash: #{win.cash}"
    else
      @player.cash += (@bank / 2)
      @dealer.cash += (bank / 2)
      p ' Nobody wins('
    end
  end

  def new_game
    line
    p 'Want to play else? 1 - Yes, 2 - NO'
    answer = gets.chomp.to_i
    case answer
    when 1
      cancel_game
      start
    when 2
      p "Ok, #{@player.name} That was a  Good Game. See you later"
      abort
    end
  end

  def who_win?
    if @player.scores > @dealer.scores && @player.scores <= 21
      @player
    elsif @player.scores > @dealer.scores && @player.scores > 21
      @dealer
    elsif @dealer.scores > @player.scores && @dealer.scores <= 21
      @dealer
    elsif @dealer.scores > @player.scores && @dealer.scores > 21
      @player
    else
      false
    end
  end

  def show_cards(user)
    p "<==== #{user.name} cards: #{user.hand.each { |card| print card.show }} Scores: #{user.scores}"
  end

  # special for check logic 'calculate_cards!' with aces
  def to_ace(deck)
    deck.cards.each { |card| card.rank = 'A' }
  end

  def take_card(user)
    raise 'Cant take card if you have more than 2' if user.hand.size > 2
    card = @deck.cards.slice!(0)
    user.hand << card
    user.calculate_cards!
  end



  private

  def cancel_game
    @player.hand.clear
    @dealer.hand.clear
    @bank = 0
  end

  def make_beats(value)
    @player.beat(value)
    @dealer.beat(value)
    @bank += (value * 2)
  end

  def line
    p '-----------------------------------------'
  end

  def show_dealer_cards_size
    p "Dealer have #{@dealer_cards.size} cards. Cash: #{@dealer.cash} "
  end

  # experimental method with using Comparable in User class
  def get_winner(user, dealer)
    return user if user <=> dealer
    return dealer if dealer <=> user
    false
  end
end
