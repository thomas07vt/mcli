require "spec_helper"

describe 'mcli' do
  context '-v' do
    it 'returns the version' do
      run_simple "mcli -v"
      expect(last_command_started.output).to eq "#{MCLI::VERSION}\n"
    end
  end
end

