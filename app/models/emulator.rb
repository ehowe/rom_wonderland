class Emulator < ActiveRecord::Base
  acts_as_paranoid

  self.per_page = 20

  has_many :emulators_systems, class_name: "EmulatorsSystem"
  has_many :systems, through: :emulators_systems

  serialize :data, JSON

  has_attached_file :emulator
  validates_attachment_content_type :emulator, content_type: "application/zip"

  validates_uniqueness_of :name, conditions: lambda { where(deleted_at: nil) }
  validates_uniqueness_of :emulator_file_name, conditions: lambda { where(deleted_at: nil) }
end
