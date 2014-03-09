module QuestQuest
  class MessageParser
    def initialize(options)
      @player = options.fetch(:from)
      @message = JSON.parse options.fetch(:message)
    end

    def parse
      case @message['type'].to_sym
      when :name_change
        @player.name = @message['name']
        :name_changed
      end
    end
  end
end
