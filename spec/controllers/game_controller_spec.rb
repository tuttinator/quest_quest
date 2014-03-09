require 'spec_helper'

module QuestQuest
  describe GameController do
    let(:game_controller) { GameController.new }

    let(:connection) { double('connection') }

    before do
      connection.stub(:send).and_return(true)
      connection.stub(:signature).and_return(1)
    end


    describe '#handle' do

      context ':open event' do

        it 'increases the number of players on the :open event' do
          player_count = game_controller.players.count
          game_controller.handle({connection: connection, type: :open})
          expect(game_controller.players.count).to eq(player_count + 1)
        end

        it 'sends the player the map'

        it 'broadcasts to all players that a new player has joined'
      end
    end

  end
end
