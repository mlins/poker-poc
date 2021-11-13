require "test_helper"

require "card"

class TestCard < Minitest::Test
  def setup
    @high_card = Card.new(suit: :h, rank: :a)
    @low_card = Card.new(suit: :d, rank: :t)
  end

  def test_greater_than
    assert @high_card > @low_card
  end

  def test_less_than
    assert @low_card < @high_card
  end

  def test_equal
    assert @high_card == @high_card
    assert @low_card == @low_card
  end
end
