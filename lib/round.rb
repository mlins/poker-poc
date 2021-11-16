require "hand"

class Round
  attr_reader :hands

  def initialize(hand_1, hand_2)
    @hands = [hand_1, hand_2]
  end

  def winner
    @hands[0] > @hands[1] ? 0 : 1
  end
end
