class User
  include Comparable
  attr_accessor :name, :hand, :scores, :cash

  def initialize(name)
    @name = name
    @cash = 100
    @hand = []
    @scores = calculate_cards!
  end

  def beat(value)
    @cash -= value
  end

  def <=>(other)
    scores > other.scores && scores <= 21
  end

  def winning(value)
    @cash += value
  end

  def calculate_cards!
    value = 0
    if hand.size.zero?
      value
    else
      @hand.each do |card|
        mid_value = card.value
        if card.ace?
          if scores < 11
            card.value
          else
            mid_value = 1
          end
        end
        value += mid_value
        @scores = value
      end
    end
  end

  def ace_value(value); end

  def show_cards
    @hand.each { |card| print card.to_s }
  end
end
