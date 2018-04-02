class Card
  attr_accessor :rank, :suit
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    return rank.to_i if %w[2 3 4 5 6 7 8 9 10].include?(rank)
    return 10 if %w[J Q K].include?(rank)
    11 if ['A'].include?(rank)
  end

  def show
    "|#{rank} - #{suit}|"
  end

  def ace?
    rank == 'A'
  end
end
