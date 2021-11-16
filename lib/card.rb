class Card
  include Comparable

  SUITS = [:h, :d, :s, :c]
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, :t, :j, :q, :k, :a]

  attr_reader :suit, :rank

  def initialize(suit:, rank:)
    @suit = suit
    @rank = rank
  end

  def natural_rank
    RANKS.index(rank)
  end

  def <=>(other)
    natural_rank <=> other.natural_rank
  end
end
