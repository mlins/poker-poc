class Hand
  attr_reader :cards

  HAND_RANKS = [
    :high_card,
    :pair,
    :two_pair,
    :three_kind,
    :straight,
    :flush,
    :full_house,
    :four_kind,
    :straight_flush,
    :royal_flush
  ]

  def initialize(hand_string)
    @cards = []

    hand_string.split(" ").each do |card_string|
      rank = Integer(card_string.chars[0]) rescue card_string.chars[0].downcase.to_sym

      @cards << Card.new(
        rank: rank,
        suit: card_string.chars[1].downcase.to_sym
      )
    end

    @cards.sort!
  end

  def grouped_by_rank
    @grouped_by_rank ||=
      @cards.group_by { |card| card.rank }
  end

  def grouped_by_suit
    @grouped_by_suit ||=
      @cards.group_by { |card| card.suit }
  end

  def grouped_by_sequence
    @cards.slice_when do |card_before, card_after|
      card_before.natural_rank + 1 != card_after.natural_rank
    end.to_a
  end

  def has?(hand)
    raise ArgumentError unless HAND_RANKS.include?(hand)

    !public_send(hand).empty?
  end

  def royal_flush
    @royal_flush ||=
      has?(:straight_flush) && cards.last.rank == :a ? straight_flush : []
  end

  def straight_flush
    @straight_flush ||=
      has?(:straight) && has?(:flush) ? straight : []
  end

  def four_kind
    @four_kind ||=
      grouped_by_rank.values.select { |cards| cards.count == 4 }.flatten
  end

  def full_house
    @full_house ||=
      has?(:three_kind) && has?(:pair) ? (three_kind + pair).sort : []
  end

  def flush
    @flush ||=
      grouped_by_suit.values.select { |cards| cards.count == 5 }.flatten
  end

  def wheel_straight
    @wheel_straight ||=
      [:a, 2, 3, 4, 5].map do |rank|
        @cards.find { |card| card.rank == rank }
      end.compact
  end

  def wheel_straight?
    wheel_straight.count == 5
  end

  def straight
    @straight ||=
      wheel_straight? ? wheel_straight : grouped_by_sequence.find { |cards| cards.count == 5 } || []
  end

  def three_kind
    @three_kind ||=
      grouped_by_rank.values.select { |cards| cards.count == 3 }.flatten
  end

  def pairs
    @pairs ||=
      grouped_by_rank.values.select { |cards| cards.count == 2 }.flatten.sort
  end

  def two_pair
    @two_pair ||=
      pairs.count == 4 ? pairs : []
  end

  def pair
    @pair ||=
      pairs.count == 2 ? pairs : []
  end

  def high_card
    [@cards.max]
  end
end
