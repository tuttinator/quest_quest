module QuestQuest
  class GameServer
    def initialize
      @game = GameController.new
    end

    def run
      EventMachine.run do
        trap("TERM") { self.stop }
        trap("INT")  { self.stop }
        EventMachine::WebSocket.run('0.0.0.0', '8080') do |socket|

          socket.onopen do |connection|
            @game.handle connection: connection, type: :open
          end
          socket.onmessage do |connection|
            @game.handle connection: connection, type: :message
          end
          socket.onclose do |connection|
            @game.handle connection: connection, type: :close

          end
        end
      end
    end

    def stop
      EventMachine.stop
    end
  end
end
