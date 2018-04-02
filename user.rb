class User
  include Comparable
  attr_accessor :name, :hand, :scores, :cash

  def initialize(name)
    @name = name
    @cash = 100
    @hand = []
    @scores = 0
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

  def show_cards
    @hand.each { |card| print card.to_s }
  end
end
