require "test_helper"

class TestRound < Minitest::Test
  def setup
    @player_1 = Hand.new("AH AD 7S TC KS")
    @player_2 = Hand.new("5C 8D 7C JS QD")

    @round = Round.new(
      @player_1,
      @player_2
    )
  end

  def test_winner
    assert @player_1, @round.hands[@round.winner]
  end
end
