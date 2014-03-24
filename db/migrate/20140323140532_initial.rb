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
  end
end
