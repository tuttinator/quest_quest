# Gem dependencies
require 'eventmachine'
require 'em-websocket'
require 'json'
require 'paint'

Dir[File.dirname(__FILE__) + '/quest_quest/**/*.rb'].each do |file|
  require file
end

# Main entrypoint
module QuestQuest
  def self.run
     GameServer.new.run
  end
end
