class System < ActiveRecord::Base
  acts_as_paranoid

  has_many :games
  has_many :emulators, through: :emulators_systems, scope: lambda { where(emulator_for_system: true) }

  def info
    RomWonderland.gamesdb.platforms.all.detect { |p| p.name == self.name }
  end

  def api_games
    games = RomWonderland.redis.cache(key: self.id, expire: 1.days, timeout: 10) do
      self.info.games.map(&:game_title).to_json
    end
    JSON.parse(games).sort
  end
end
