class AddEmulatorToEmulators < ActiveRecord::Migration
  def up
    add_attachment :emulators, :emulator
  end

  def down
    remove_attachment :emulators, :emulator
  end
end
