class Deck
  attr_accessor :name, :cards, :user

  def initialize(name, user)
    @name = name
    @user = user
    @cards = []
  end
end
