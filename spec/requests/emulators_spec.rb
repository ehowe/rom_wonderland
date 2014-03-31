require 'spec_helper'

describe "emulators" do
  let(:client) { create_client }

  context "with a system" do
    let(:system) { System.where(name: "Super Nintendo (SNES)").first }
    let(:emulator_name) { "OpenEMU" }
    let(:emulator_path) { "#{Rails.root}/spec/files/emulators/OpenEmu_1.0.1.zip" }

    it "should create an emulator" do
      emulator = create_emulator(system: system, emulator: {name: emulator_name, emulator: emulator_path})
      emulator.name.should == emulator_name
      emulator.emulator_file_size.should_not be_nil
      emulator.emulator_file_name.should == emulator_path.split('/').last
      emulator.emulator_content_type.should == "application/zip"
      emulator.emulator_update_at.should_not be_nil
    end
  end
end
