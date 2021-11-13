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

  def test_card_ranks
    assert_equal([:a, :k, :q, :j, :t], @high_hand.ranks)
  end

  def test_natural_ranks
    assert_equal([8, 9, 10, 11, 12], @high_hand.natural_ranks)
  end

  def test_card_suits
    assert_equal([:c, :d, :h, :c, :s], @low_hand.suits)
  end

  def test_card_rank_counts
    assert @high_hand.rank_counts == {
      t: 1,
      j: 1,
      q: 1,
      k: 1,
      a: 1
    }
  end

  def test_royal_flush
    happy_hand = Hand.new("TH JH QH KH AH")
    sad_hand = Hand.new("5H 6H 7H 8H 9H")

    assert happy_hand.royal_flush?
    refute sad_hand.royal_flush?
  end

  def test_straight_flush
    happy_hand = Hand.new("5H 6H 7H 8H 9H")
    sad_hand_1 = Hand.new("AH 9H TH 2H KH")
    sad_hand_2 = Hand.new("5H 6C 7H 8S 9D")

    assert happy_hand.straight_flush?
    refute sad_hand_1.straight_flush?
    refute sad_hand_2.straight_flush?
  end

  def test_four_kind
    happy_hand = Hand.new("AH AC AS AD KH")
    sad_hand = Hand.new("AH AC AS KD QH")

    assert happy_hand.four_kind?
    refute sad_hand.four_kind?
  end

  def test_full_house
    happy_hand = Hand.new("AH AC AS KD KH")
    sad_hand = Hand.new("AH AC AS KD QH")

    assert happy_hand.full_house?
    refute sad_hand.full_house?
  end

  def test_flush
    happy_hand = Hand.new("AH 9H TH 2H KH")
    sad_hand = Hand.new("AH AC AS KD QH")

    assert happy_hand.flush?
    refute sad_hand.flush?
  end

  def test_straight
    happy_hand_1 = Hand.new("5H 6C 7H 8S 9D")
    happy_hand_2 = Hand.new("2D 3D 4D 5D AD")
    sad_hand = Hand.new("AH AC AS KD QH")

    assert happy_hand_1.straight?
    assert happy_hand_2.straight?
    refute sad_hand.straight?
  end

  def test_three_kind
    happy_hand = Hand.new("AH AC AS JD KH")
    sad_hand = Hand.new("AH AC JS KD QH")

    assert happy_hand.three_kind?
    refute sad_hand.three_kind?
  end

  def test_two_pair?
    happy_hand = Hand.new("AH AC JS JD KH")
    sad_hand = Hand.new("AH AC JS KD QH")

    assert happy_hand.two_pair?
    refute sad_hand.two_pair?
  end

  def test_pair
    happy_hand = Hand.new("AH AC QS JD KH")
    sad_hand = Hand.new("AH 4C JS KD QH")

    assert happy_hand.pair?
    refute sad_hand.pair?
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
