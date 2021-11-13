class Hand
  attr_reader :cards

  RANKS = [
    :high_card,
    :one_pair,
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
  end

  def ranks
    @ranks ||=
      @cards.map { |card| card.rank }
  end

  def natural_ranks
    @natural_ranks ||=
      @cards.map { |card| card.natural_rank }.sort
  end

  def low_ace_natural_ranks
    @low_ace_natural_ranks ||=
      @cards.map { |card| card.natural_rank(low_ace: true) }.sort
  end

  def suits
    @suits ||=
      @cards.map { |card| card.suit }
  end

  def rank_counts
    @rank_counts ||=
      ranks.uniq.map { |rank| [rank, ranks.count(rank)] }.to_h
  end

  def any_rank_count_of?(count_wanted)
    rank_counts.values.any? { |count| count == count_wanted}
  end

  def royal_flush?
    straight_flush? && cards.last.natural_rank == Card::RANKS.count - 1
  end

  def straight_flush?
    straight? && flush?
  end

  def four_kind?
    any_rank_count_of?(4)
  end

  def full_house?
    any_rank_count_of?(3) && any_rank_count_of?(2)
  end

  def flush?
    suits.uniq.count == 1
  end

  def straight?
    natural_ranks.each_cons(2).all? { |x,y| y == x + 1 } ||
    low_ace_natural_ranks.each_cons(2).all? { |x,y| y == x + 1 }
  end

  def three_kind?
    any_rank_count_of?(3)
  end

  def two_pair?
    rank_counts.values.count(2) == 2
  end

  def pair?
    any_rank_count_of?(2)
  end
end
