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

  def test_grouped_by_rank
    assert_equal({
      a: [Card.new(rank: :a, suit: :h)],
      k: [Card.new(rank: :k, suit: :h)],
      q: [Card.new(rank: :q, suit: :h)],
      j: [Card.new(rank: :j, suit: :h)],
      t: [Card.new(rank: :t, suit: :h)]
    }, @high_hand.grouped_by_rank)
  end

  def test_grouped_by_suit
    assert_equal({
      h: Hand.new("AH KH QH JH TH").cards
    }, @high_hand.grouped_by_suit)
  end

  def test_grouped_by_sequence
    hand = Hand.new("TH JC QH KS AD")

    assert_equal(
      [hand.cards],
      hand.grouped_by_sequence
    )
  end

  def test_has?
    assert @high_hand.has?(:royal_flush)
    refute @low_hand.has?(:royal_flush)
    assert_raises(ArgumentError) { @high_hand.has?(:not_a_valid_hand) }
  end

  def test_royal_flush
    happy_hand = Hand.new("TH JH QH KH AH")
    sad_hand = Hand.new("5H 6H 7H 8H 9H")

    assert happy_hand.has?(:royal_flush)
    refute sad_hand.has?(:royal_flush)
  end

  def test_straight_flush
    happy_hand = Hand.new("5H 6H 7H 8H 9H")
    sad_hand_1 = Hand.new("AH 9H TH 2H KH")
    sad_hand_2 = Hand.new("5H 6C 7H 8S 9D")

    assert happy_hand.has?(:straight_flush)
    refute sad_hand_1.has?(:straight_flush)
    refute sad_hand_2.has?(:straight_flush)

    assert_equal(Hand.new("5H 6H 7H 8H 9H").cards, happy_hand.straight_flush)
    assert_equal([], sad_hand_1.straight_flush)
    assert_equal([], sad_hand_2.straight_flush)
  end

  def test_four_kind
    happy_hand = Hand.new("AH AC AS AD KH")
    sad_hand = Hand.new("AH AC AS KD QH")

    assert happy_hand.has?(:four_kind)
    refute sad_hand.has?(:four_kind)

    assert_equal(Hand.new("AH AC AS AD").cards, happy_hand.four_kind)
    assert_equal([], sad_hand.four_kind)
  end

  def test_full_house
    happy_hand = Hand.new("AH AC AS KD KH")
    sad_hand = Hand.new("AH AC AS KD QH")

    assert happy_hand.has?(:full_house)
    refute sad_hand.has?(:full_house)

    assert_equal(Hand.new("AH AC AS KD KH").cards, happy_hand.full_house)
    assert_equal([], sad_hand.full_house)
  end

  def test_flush
    happy_hand = Hand.new("AH 9H TH 2H KH")
    sad_hand = Hand.new("AH AC AS KD QH")

    assert happy_hand.has?(:flush)
    refute sad_hand.has?(:flush)

    assert_equal(Hand.new("AH 9H TH 2H KH").cards, happy_hand.flush)
    assert_equal([], sad_hand.flush)
  end

  def test_wheel_straight
    happy_hand = Hand.new("2D 3S 4D 5D AD")
    sad_hand_1 = Hand.new("TD JS QD KD AD")
    sad_hand_2 = Hand.new("2D 6S 4D 5D AD")

    assert happy_hand.wheel_straight?
    refute sad_hand_1.wheel_straight?
    refute sad_hand_2.wheel_straight?
  end

  def test_straight
    happy_hand_1 = Hand.new("5H 6C 7H 8S 9D")
    happy_hand_2 = Hand.new("2D 3S 4D 5D AD")
    happy_hand_3 = Hand.new("TD JS QD KD AD")
    sad_hand = Hand.new("AH AC AS KD QH")

    assert happy_hand_1.has?(:straight)
    assert happy_hand_2.has?(:straight)
    assert happy_hand_3.has?(:straight)
    refute sad_hand.has?(:straight)

    assert_equal(Hand.new("5H 6C 7H 8S 9D").cards, happy_hand_1.straight)
    assert_equal(Hand.new("AD 2D 3S 4D 5D").wheel_straight, happy_hand_2.straight)
    assert_equal(Hand.new("TD JS QD KD AD").cards, happy_hand_3.straight)
    assert_equal([], sad_hand.straight)
  end

  def test_three_kind
    happy_hand = Hand.new("AH AC AS JD KH")
    sad_hand = Hand.new("AH AC JS KD QH")

    assert happy_hand.has?(:three_kind)
    refute sad_hand.has?(:three_kind)

    assert_equal(Hand.new("AH AC AS").cards, happy_hand.three_kind)
    assert_equal([], sad_hand.three_kind)
  end

  def test_two_pair
    happy_hand = Hand.new("AH AC JS JD KH")
    sad_hand = Hand.new("AH AC AS AD QH")

    assert happy_hand.has?(:two_pair)
    refute sad_hand.has?(:two_pair)

    assert_equal(Hand.new("AH AC JS JD").cards, happy_hand.two_pair)
    assert_equal([], sad_hand.two_pair)
  end

  def test_pair
    happy_hand = Hand.new("AH AC QS JD KH")
    sad_hand = Hand.new("AH 4C JS KD QH")

    assert happy_hand.has?(:pair)
    refute sad_hand.has?(:pair)

    assert_equal(Hand.new("AH AC").cards, happy_hand.pair)
    assert_equal([], sad_hand.pair)
  end

  def test_high_card
    happy_hand = Hand.new("AH 2C QS 8D 4H")

    assert happy_hand.has?(:high_card)

    assert_equal(Hand.new("AH").cards, happy_hand.high_card)
  end

  def test_best_hand
    assert_equal(:royal_flush, @high_hand.best_hand)
    assert_equal(:high_card, @low_hand.best_hand)
    refute_equal(:high_card, @high_hand.best_hand)
  end

  def test_best_hand_cards
    assert_equal(@high_hand.cards, @high_hand.best_hand_cards)
    assert_equal(Hand.new("KC").cards, @low_hand.best_hand_cards)
  end

  def test_kickers
    two_pair = Hand.new("AH AC JS JD KH")
    pair = Hand.new("AH AC QS JD KH")

    assert_equal(Hand.new("KH").cards, two_pair.kickers)
    assert_equal(Hand.new("QS JD KH").cards, pair.kickers)
  end

  def test_natural_rank
    assert_equal(9, @high_hand.natural_rank)
  end

  def test_greater_than
    assert @high_hand > @low_hand
  end

  def test_less_than
    assert @low_hand < @high_hand
  end

  def test_equal
    assert @high_hand == @high_hand
    assert @low_hand == @low_hand
  end

  def test_equal_natural_ranks_without_kickers
    high_straight = Hand.new("TH JC QS KD AC")
    low_straight = Hand.new("9H TC JS QD KC")

    high_full_house = Hand.new("9H 9D KD KH KS")
    low_full_house = Hand.new("9C 9S QD QH QS")

    high_pair = Hand.new("QH QC 4S 3C AH")
    low_pair = Hand.new("9H 9C 4S 3C AH")

    assert high_straight > low_straight
    assert high_full_house > low_full_house
    assert high_pair > low_pair
  end

  def test_equal_natural_ranks_with_kickers
    high_pair_1 = Hand.new("QH QC AC 8S 6D")
    low_pair_1 = Hand.new("QD QS KD 7S 2H")

    high_pair_2 = Hand.new("QH QC AC 8S 6D")
    low_pair_2 = Hand.new("QD QS AD 8C 2H")

    assert high_pair_1 > low_pair_1
    assert high_pair_2 > low_pair_2
  end
end
