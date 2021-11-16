require "test_helper"

class TestGame < Minitest::Test
  def setup
    @game = Game.new("8C TS KC 9H 4S 7D 2S 5D 3S AC")
  end

  def test_game_rounds
    assert_equal(Hand.new("8C TS KC 9H 4S"), @game.rounds[0].hands[0])
    assert_equal(Hand.new("7D 2S 5D 3S AC"), @game.rounds[0].hands[1])
  end
end
