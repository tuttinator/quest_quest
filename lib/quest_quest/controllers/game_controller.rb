module QuestQuest
  class GameController
    attr_reader :players
    attr_accessor :name

    def initialize
      @players = []
    end

    def handle(event)
      case event[:type]
      when :open
        add_new_player(event[:connection])

      when :message
        result = MessageParser.new(message: event[:event], from: find_player(event[:connection])).parse
        acknowledge result
        
      when :close
        @players.delete find_player(event[:connection])
        announce 'A player has left'

      end
    end

    def add_new_player(connection)
      player = Player.new(connection)
      @players << player

      announce 'New player has joined'

      # send the map to the player
    end

    private

    def find_player(connection)
       @players.detect {|player| player.socket_id == connection.signature }
    end

    def announce(message)

      puts message

      broadcast(message: message,
                player_count: @players.count,
                players: @players.map {|p| p.name},
                type: :announcement)
    end

    def acknowledge(result)
      if result == :name_changed
        broadcast(player_count: @players.count,
                  players: @players.map {|p| p.name},
                  type: :acknowledgement)
      end
    end

    def broadcast(message)
      @players.each do |player|
        player.message(message)
      end
    end

  end
end
