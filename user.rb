class User
  attr_accessor :name, :hand, :scores

  def initialize(name)
    @name = name
    @cash = 100
    @hand = []
    @scores = calculate_cards!
  end


  def calculate_cards!
    value = 0
    @hand.each do |card|
      value += card.value
    end
   @scores =  value
  end

  def show_cards
    @hand.each { |card| print "#{card}"}
  end

end