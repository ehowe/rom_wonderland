require 'spec_helper'

describe "games" do
  let(:client) { create_client }

  context "with a system" do
    let(:system)    { System.where(name: "Super Nintendo (SNES)").first }
    let(:game_name) { "The Legend of Zelda: A Link to the Past" }
    let(:rom)       { "#{Rails.root}/spec/files/roms/LoZLTP.zip" }

    it "should create a game" do
      real_game = system.info.games.first

      game = create_game(system: system, game: {name: game_name, rom: rom})
      game.rom_file_size.should_not be_nil
      game.rom_file_name.should == rom.split('/').last
      game.rom_content_type.should == "application/zip"
      game.rom_updated_at.should_not be_nil
    end

    context "with a game" do
      let!(:game) { create_game(system: system, game: {name: game_name, rom: rom}) }

      it "should destroy a game" do
        client.delete game_path(game.id), format: :json
        json.game.deleted_at.should_not be_nil
      end

      it "should list all games" do
        client.get games_path, format: :json

        json.games.should_not be_empty

        client.get game_path(json.games.first.id), format: :json
        db_game = Game.find(json.game.id)

        db_game.attributes.should == game.attributes
      end
    end
  end
end
