module QuestQuest
  class Player
    attr_reader :alive
    attr_reader :connection
    attr_accessor :name
    attr_reader :x, :y

    def initialize(connection)
      @connection = connection
      @alive = true
      @name = "Anonymous user ##{socket_id}"
    end

    def coordinates=(coords)
      @x, @y = coords.first, coords.last
    end

    def coordinates
      [@x, @y]
    end

    def valid?
      !@connection.nil? and coordinates_set?
    end

    def socket_id
      connection.signature
    end

    def message(message)
      connection.send(message.to_json)
    end

    def as_json
      { x: @x, y: @y, player_id: socket_id, type: :player }
    end

    private

    def coordinates_set?
      !@x.nil? and !@y.nil?
    end
  end
end
