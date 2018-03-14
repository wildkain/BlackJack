class Deck
attr_accessor :cards

  def initialize
    @cards = Deck.build
  end

  def self.build
    @cards  = []
    Card::RANKS.each do |rank|
      Card::SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end
    @cards.shuffle!
  end


end