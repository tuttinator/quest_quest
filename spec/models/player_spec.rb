require 'spec_helper'

module QuestQuest
  describe Player do

    let(:connection) { double('connection') }

    before do
      connection.stub(:send).and_return(true)
    end

    it 'is alive when first created' do
      expect(Player.new(connection).alive).to be_true
    end

    context 'validation' do

      it 'is not valid until the coordinates are set' do
        expect(Player.new(connection)).to_not be_valid
      end

      context 'with coordinates' do

        before do
          @player = Player.new(connection)
          @player.coordinates = [0, 0]
        end

        it 'is valid with coordinates set' do
          expect(@player).to be_valid
        end

      end

    end
  end
end
