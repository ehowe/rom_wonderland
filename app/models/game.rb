class Game < ActiveRecord::Base
  acts_as_paranoid

  self.per_page = 20

  belongs_to :system

  has_attached_file :rom
  validates_attachment_content_type :rom, content_type: "application/zip"

  validate :name, if: :exists_at_gamesdb?
  validates_uniqueness_of :name, conditions: lambda { where(deleted_at: nil) }

  def info
    self.system.info.games.detect { |g| g.game_title == self.name }
  end

  def exists_at_gamesdb?
    errors.add(self.name, "does not appear to be a valid game") unless self.system.api_games.detect { |g| g == self.name }
  end
end
