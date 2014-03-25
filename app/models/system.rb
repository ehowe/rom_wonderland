class System < ActiveRecord::Base
  acts_as_paranoid

  has_many :games

  def info
    RomWonderland.gamesdb.platforms.all.detect { |p| p.name == self.name }
  end

  def api_games
    if system_key = RomWonderland.redis.get(self.id)
      JSON.parse(system_key)
    else
      games = self.info.games.map(&:game_title)
      RomWonderland.redis.set(self.id, games.to_json)
      games
    end
  end
end
