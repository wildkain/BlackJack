require_relative 'interface.rb'
class User
  attr_accessor :name, :hand, :scores, :cash

  def initialize(name)
    @name = name
    @cash = 100
    @hand = []
    @scores = 0
  end

  def bet(value)
    @cash -= value
  end

  def winning(value)
    @cash += value
  end
end
