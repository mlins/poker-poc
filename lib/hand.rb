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

    @cards.sort!
  end
end
