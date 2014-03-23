class Game < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :system

  has_attached_file :rom
  validates_attachment_content_type :rom, content_type: "application/zip"

  def info
    self.system.api_games.detect { |g| g.game_title == self.name }
  end
end
