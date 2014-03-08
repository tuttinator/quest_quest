module QuestQuest
  class GameController
    attr_reader :players

    def initialize
      @players = []
    end

    def handle(event)
      case event[:type]
      when :open
        @players << Player.new(event[:connection])
      when :message
        # parse message
      when :close
        # remove player
      end
    end
  end
end
