class System < ActiveRecord::Base
  acts_as_paranoid

  has_many :games

  def info
    RomWonderland.gamesdb.platforms.all.detect { |p| p.name == self.name }
  end

  def api_games
    self.info.games
  end
end
