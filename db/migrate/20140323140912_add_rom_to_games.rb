class AddRomToGames < ActiveRecord::Migration
  def up
    add_attachment :games, :rom
  end

  def down
    remove_attachment :games, :rom
  end
end
