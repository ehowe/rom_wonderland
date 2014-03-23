# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env == "development" || Rails.env == "test"
  User.where(email: "test@example.com", password: "testtest", password_confirmation: "testtest").first_or_create
end

#NES, SNES, Genesis
systems = %w(7 6 18)
platforms = RomWonderland.gamesdb.platforms.all.select { |p| systems.include?(p.id) }
platforms.each do |platform|
  System.where(name: platform.name).first_or_create
end
