class Card
  include Comparable

  SUITS = [:h, :d, :s, :c]
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, :t, :j, :q, :k, :a]

  attr_reader :suit, :rank

  def initialize(suit:, rank:)
    @suit = suit
    @rank = rank
  end

  def <=>(other)
    RANKS.index(rank) <=> RANKS.index(other.rank)
  end
end
