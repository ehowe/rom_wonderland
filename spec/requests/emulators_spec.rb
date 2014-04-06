require 'spec_helper'

describe "emulators" do
  let(:client) { create_client }

  context "with a system" do
    let(:system)             { System.where(name: "Super Nintendo (SNES)").first }
    let(:emulator_name)      { "OpenEMU" }
    let(:emulator_file_path) { "#{Rails.root}/spec/files/emulators/OpenEmu_1.0.1.zip" }

    it "should create an emulator" do
      emulator = create_emulator(system: system, emulator: {name: emulator_name, emulator: emulator_file_path})
      emulator.name.should == emulator_name
      emulator.emulator_file_size.should_not be_nil
      emulator.emulator_file_name.should == emulator_file_path.split('/').last
      emulator.emulator_content_type.should == "application/zip"
      emulator.emulator_updated_at.should_not be_nil
    end

    context "with an emulator" do
      let!(:emulator) { create_emulator(system: system, emulator: {name: emulator_name, emulator: emulator_file_path}) }

      it "should destroy a game" do
        client.delete emulator_path(emulator.id), format: :json
        json.emulator.deleted_at.should_not be_nil
      end

      it "should list all emulators" do
        client.get emulators_path, format: :json

        json.emulators.should_not be_empty

        client.get emulator_path(json.emulators.first.id), format: :json
        db_emulator = Emulator.find(json.emulator.id)

        db_emulator.attributes.should == emulator.attributes
      end
    end
  end
end
