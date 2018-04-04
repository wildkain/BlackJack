class Interface
  def welcome_message
    line
    p 'Welcome to BlackJack game!'
    p 'We hope you are Lucky Guy!'
    line
  end

  def ask_name
    p 'What is your name? Please enter:'
    gets.chomp.to_s
  end

  def get_action
    p "What you to do? Enter |'1' - Hit!|, |'2' - Stand|, |'3' - show cards|"
    gets.chomp.to_i
  end

  def greeting(player_name)
    p "Exellent, #{player_name}! Lets start our adventures!"
    line
  end

  def show_info(user)
    p "#{user.name} Cards #{user.hand}. Scores: #{user.scores}. Cash: #{user.cash}"
  end

  def prepare_deck
    p 'Now we prepare deck and shuffle'
    p 'You and the dealer get 2 cards'
  end

  def line
    p '------------------------------------------'
  end

  def show_cards(user)
    p "<==== #{user.name} cards: #{user.hand.each { |card| print card.show }} Scores: #{user.scores}"
  end

  def show_dealer_cards(user)
    p "Dealer have #{user.hand.size} cards. Cash: #{user.cash} "
  end

  def show_last_card(user)
    p "#{user.name} are take card: #{user.hand[2].show}"
  end

  def new_game_answer
    p 'Want to play else? 1 - Yes, 2 - NO'
    gets.chomp.to_i
  end

  def goodbye
    'This is GOOD GAME, Bro! See you later.'
  end

  def no_money_no_honey
    p "So sorry. We can't play else("
  end

  def show_winner(user)
    p "#{user.name}  WIN!!! Scores: #{user.scores} Cash: #{user.cash}"
  end

  def nobody_wins
    p ' Nobody wins('
  end
end
