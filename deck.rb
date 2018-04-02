class Deck

  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[diamonds clubs hearts spades].freeze

  attr_accessor :cards

  def initialize
    @cards = Deck.build
  end

  def self.build
    @cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end
    @cards.shuffle!
  end
end
