module ResourceHelper
  def create_game(options={})
    system = options[:system]

    if rom_path = options[:game][:rom]
      options[:game][:rom] = {}
      options[:game][:rom][:data] = Base64.encode64(File.open(rom_path, "rb").read)
      options[:game][:rom][:filename] = rom_path.split('/').last
      options[:game][:rom][:content_type] = "application/zip"
    end

    client.post systems_games_path(id: system.id), options.merge(format: :json)

    client.get game_path(json.game.id), format: :json
    json.game.id.should_not be_nil
    json.game.name.should_not be_nil

    Game.find(json.game.id)
  end

  def create_emulator(options={})
    system = options[:system]

    if emulator_path = options[:emulator][:emulator]
      options[:emulator][:emulator] = {}
      options[:emulator][:emulator][:data] = Base64.encode64(File.open(emulator_path, "rb").read)
      options[:emulator][:emulator][:filename] = emulator_path.split('/').last
      options[:emulator][:emulator][:content_type] = "application/zip"
    end

    client.post systems_emulators_path(id: system.id), options.merge(format: :json)

    client.get emulator_path(json.emulator.id), format: :json
    json.emulator.id.should_not be_nil
    json.emulator.name.should_not be_nil

    Emulator.find(json.emulator.id)
  end
end

RSpec.configure do |config|
  config.include(ResourceHelper)
end
