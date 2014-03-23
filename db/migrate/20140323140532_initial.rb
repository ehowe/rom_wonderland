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

    create_table :users, id: :uuid do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true

    create_table :favorite_systems, id: :uuid do |t|
      t.string :user_id
      t.string :system_id
    end

    add_index :favorite_systems, :user_id
    add_index :favorite_systems, :system_id
  end
end
