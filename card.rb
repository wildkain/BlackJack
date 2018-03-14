class Card
  RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"].freeze
  SUITS = ["diamonds", "clubs", "hearts", "spades"].freeze
  attr_reader :rank, :suit
  def initialize(rank, suit)
    @rank =  rank
    @suit = suit
  end

  def value
    return self.rank.to_i if ["2", "3", "4", "5", "6", "7", "8", "9", "10"].include?(self.rank)
    return 10 if ["J", "Q", "K", "A"].include?(self.rank)
  end

end