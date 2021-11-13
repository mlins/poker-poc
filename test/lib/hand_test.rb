require "test_helper"

class TestHand < Minitest::Test
  def setup
    @high_hand = Hand.new("AH KH QH JH TH")
    @low_hand = Hand.new("8C TD 2H KC QS")
  end

  def test_hand_init
    assert @high_hand.cards.include?(Card.new(rank: :a, suit: :h))
    assert @high_hand.cards.include?(Card.new(rank: :k, suit: :h))
    assert @high_hand.cards.include?(Card.new(rank: :q, suit: :h))
    assert @high_hand.cards.include?(Card.new(rank: :j, suit: :h))
    assert @high_hand.cards.include?(Card.new(rank: :t, suit: :h))

    assert @low_hand.cards.include?(Card.new(rank: 8, suit: :c))
    assert @low_hand.cards.include?(Card.new(rank: :t, suit: :d))
    assert @low_hand.cards.include?(Card.new(rank: 2, suit: :h))
    assert @low_hand.cards.include?(Card.new(rank: :k, suit: :c))
    assert @low_hand.cards.include?(Card.new(rank: :q, suit: :s))
  end

  def test_cards_sorted
    assert @low_hand.cards.last == Card.new(rank: :k, suit: :c)
    assert @low_hand.cards.first == Card.new(rank: 2, suit: :h)
  end

  # def test_greater_than
  #   assert @high_hand > @low_hand
  # end

  # def test_less_than
  #   assert @low_hand < @high_hand
  # end

  # def test_equal
  #   assert @high_hand == @high_hand
  #   assert @low_hand == @low_hand
  # end
end
