require "round"

class Game
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
end
