require 'spec_helper'

describe "games" do
  let(:client) { create_client }

  context "with a system" do
    let(:system) { System.first }

    it "should create a game" do
      real_game = system.api_games.first

      game = create_game(system: system, game: {name: real_game.game_title})
      game.rom_file_size.should be_nil
      game.rom_file_name.should be_nil
      game.rom_content_type.should be_nil
      game.rom_updated_at.should be_nil
    end

    context "with a game" do
      let!(:game) { create_game(system: system, game: {name: system.api_games.first.game_title}) }

      it "should destroy a game" do
        client.delete game_path(game.id)
        json.game.deleted_at.should_not be_nil
      end

      it "should list all games" do
        client.get games_path

        json.games.should_not be_empty

        client.get game_path(json.games.first.id)
        game = Game.find(json.game.id)

        game.attributes.should == game.attributes
      end
    end
  end
end
