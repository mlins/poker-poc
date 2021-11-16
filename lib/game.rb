require "round"

class Game
  PLAYERS = 2

  attr_reader :rounds

  def initialize(data)
    @rounds = []

    data.each_line do |string|
      @rounds << Round.new(
        Hand.new(string[0, 14]),
        Hand.new(string[15, 29])
      )
    end
  end

  def wins
    @wins ||=
      (0...PLAYERS).map { |player| @rounds.select { |round| round.winner == player }.count }
  end
end
