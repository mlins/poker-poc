require "test_helper"

class TestCard < Minitest::Test
  def setup
    @high_card = Card.new(suit: :h, rank: :a)
    @low_card = Card.new(suit: :d, rank: :t)
  end

  def test_card_init
    assert_equal(2, Card.new(suit: :h, rank: 2).rank)
  end

  def test_natural_ranks_high_ace
    assert_equal(12, Card.new(suit: :h, rank: :a).natural_rank)
  end

  def test_natural_ranks_low_ace
    assert_equal(0, Card.new(suit: :h, rank: :a).natural_rank(low_ace: true))
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
