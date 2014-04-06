class Initial < ActiveRecord::Migration
  def change
    create_table :systems, id: :uuid do |t|
      t.string :name
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :games, id: :uuid do |t|
      t.string :name
      t.string :system_id
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :games, :system_id

    create_table :emulators, id: :uuid do |t|
      t.string :name
      t.text   :data
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :emulators_systems, id: :uuid do |t|
      t.uuid :system_id
      t.uuid :emulator_id
      t.boolean :emulator_for_system
    end

    add_index :emulators_systems, :system_id
    add_index :emulators_systems, :emulator_id
  end
end
