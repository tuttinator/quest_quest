module QuestQuest
  class Player

    attr_reader :alive

    def initialize(connection)
      @connection = connection
      @alive = true
    end

    def coordinates=(coords)
      @x, @y = coords.first, coords.last
    end

    def coordinates
      [x, y]
    end

    def valid?
      !@connection.nil? and coordinates_set?
    end

    private

    def coordinates_set?
      !@x.nil? and !@y.nil?
    end
  end
end
