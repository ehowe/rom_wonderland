module ResourceHelper
  def create_game(options={})
    system = options[:system]
    client.post systems_games_path(id: system.id), options.merge(format: :json)

    client.get game_path(json.game.id)
    json.game.id.should_not be_nil
    json.game.name.should_not be_nil

    Game.find(json.game.id)
  end
end

RSpec.configure do |config|
  config.include(ResourceHelper)
end
