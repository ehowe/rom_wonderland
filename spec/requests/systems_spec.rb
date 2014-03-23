require 'spec_helper'

describe 'systems' do
  let(:client) { create_client }

  it "should have systems" do
    client.get systems_path
    json.systems.should_not be_empty
  end

  it "should get a system" do
    client.get systems_path
    system = json.systems.first

    system = client.get system_path(system.id)
    json.system.should_not be_nil

    system = System.find(json.system.id)
    system.info.should_not be_nil
  end
end
