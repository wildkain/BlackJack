class Round
  attr_accessor :user, :dealer, :interface, :bank

  def initialize(user, dealer, deck, interface)
    @player = user
    @dealer = dealer
    @deck = deck
    @interface = interface
    @bank = 0
  end

  def start!
    interface.prepare_deck
    first_distribution
    make_beats(10)
    interface.show_cards(@player)
    interface.show_dealer_cards(@dealer)
    action = interface.get_action
    do_action(action)
  end

  private

  def stand
    if @dealer.hand.size < 3 && @dealer.scores < 17
      dealer_hit
    else
      interface.show_cards(@dealer)
      interface.line
      interface.show_cards(@player)
    end
  end

  def player_hit
    take_card(@player)
    interface.show_last_card(@player)
    dealer_hit
    interface.line
    open_cards
    interface.line
  end

  def dealer_hit
    return if @dealer.scores >= 17
    take_card(@dealer)
    interface.show_last_card(@dealer)
    interface.line
    open_cards
    interface.line
  end

  def first_distribution
    2.times do
      take_card(@player)
      take_card(@dealer)
    end
  end

  def do_action(action)
    case action
    when 1 then player_hit
    when 2 then stand
    when 3 then open_cards
    else
      abort
    end
    show_winner
    # new_game
  end

  def open_cards
    users = [@player, @dealer]
    users.each { |user| interface.show_info(user) }
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

  def make_beats(value)
    @player.bet(value)
    @dealer.bet(value)
    @bank += (value * 2)
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

  def take_card(user)
    raise 'Cant take card if you have more than 2' if user.hand.size > 2
    card = @deck.cards.slice!(0)
    user.hand << card
    calculate_cards!(user)
  end

  def calculate_cards!(user)
    value = 0
    if user.hand.size.zero?
      value
    else
      user.hand.each do |card|
        mid_value = card.value
        if card.ace?
          if user.scores < 11
            card.value
          else
            mid_value = 1
          end
        end
        value += mid_value
        user.scores = value
      end
    end
  end
end
