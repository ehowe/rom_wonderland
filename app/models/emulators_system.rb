class EmulatorsSystem < ActiveRecord::Base
  belongs_to :emulator
  belongs_to :system
end
