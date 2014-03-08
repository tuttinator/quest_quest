require 'spec_helper'

module QuestQuest
  describe GameController do
    let(:game_controller) { GameController.new }

    let(:connection) do
      { connection: {
          headers: {
            "Sec-WebSocket-Key" => SecureRandom.hex
          }
        }
      }
    end


    describe '#handle' do

      context ':open event' do

        it 'increases the number of players on the :open event' do
          player_count = game_controller.players.count
          game_controller.handle({connection: connection, type: :open})
          expect(game_controller.players.count).to eq(player_count + 1)
        end

      end
    end

  end
end
