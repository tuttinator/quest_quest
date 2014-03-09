module QuestQuest
  class GameServer
    def initialize
      @game = GameController.new
    end

    def run
      EventMachine.run do
        trap("TERM") { self.stop }
        trap("INT")  { self.stop }
        EventMachine::WebSocket.run(host: '0.0.0.0', port: '8080') do |socket|

          socket.onopen do |event|
            @game.handle connection: socket, event: event, type: :open
          end
          socket.onmessage do |event|
            @game.handle connection: socket, event: event, type: :message
          end
          socket.onclose do |event|
            @game.handle connection: socket, event: event, type: :close

          end
        end
      end
    end

    def stop
      EventMachine.stop
    end
  end
end
