# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140330141236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "emulators", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.text     "data"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "emulator_file_name"
    t.string   "emulator_content_type"
    t.integer  "emulator_file_size"
    t.datetime "emulator_updated_at"
  end

  create_table "emulators_systems", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid    "system_id"
    t.uuid    "emulator_id"
    t.boolean "emulator_for_system"
  end

  add_index "emulators_systems", ["emulator_id"], name: "index_emulators_systems_on_emulator_id", using: :btree
  add_index "emulators_systems", ["system_id"], name: "index_emulators_systems_on_system_id", using: :btree

  create_table "games", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.string   "system_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rom_file_name"
    t.string   "rom_content_type"
    t.integer  "rom_file_size"
    t.datetime "rom_updated_at"
  end

  add_index "games", ["system_id"], name: "index_games_on_system_id", using: :btree

  create_table "systems", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
