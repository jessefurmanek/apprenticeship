class Card
  attr_accessor :front, :back

  def initialize(title, deck)
    @front = ""
    @back = ""
    @deck = deck.name
  end

end
