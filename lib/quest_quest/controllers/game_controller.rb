module QuestQuest
  class GameController
    attr_reader :players

    def initialize
      @players = []
    end

    def handle(event)
      case event[:type]
      when :open
        puts event
        add_new_player(event[:connection])
      when :message
        # parse message
      when :close
        remove_player_from_event(event[:connection])
      end
    end

    def parse_message(event)
      puts event
    end

    def add_new_player(connection)
      player = Player.new(connection)
      @players << player

      puts 'New player joined'
      broadcast(message: 'New player has joined.', player_count: @players.count, type: :announcement)
      # send the map to the player
    end

    def remove_player_from_event(connection)
      player = @players.detect {|player| player.socket_id == connection.signature }
      @players.delete player

      puts 'Player has left'
      broadcast(message: 'A player has left.', player_count: @players.count, type: :announcement)
    end

    private

    def broadcast(message)
      @players.each do |player|
        message_player(player, message)
      end
    end

    def message_player(player, message)
      player.connection.send(message.to_json)
    end
  end
end
