require "spec_helper"

RSpec.describe MCLI do
  it "has a version number" do
    expect(MCLI::VERSION).not_to be nil
  end

  context '--version' do
    it 'prints the version' do
      run_simple "mcli --version"
      expect(last_command_started.output).to eq("#{MCLI::VERSION}\n")
    end
  end

  context '-v' do
    it 'prints the version' do
      run_simple "mcli -v"
      expect(last_command_started.output).to eq("#{MCLI::VERSION}\n")
    end
  end
end

