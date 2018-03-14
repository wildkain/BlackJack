class User
  attr_accessor :name, :hand, :scores

  def initialize(name)
    @name = name
    @cash = 100
    @hand = []
    @scores = calculate_cards!(self)
  end


  def calculate_cards!(user)
    value = 0
    user.hand.each do |card|
      value += card.value
    end
   @scores =  value
  end

end