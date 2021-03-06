require 'spec_helper'

describe MCLI::Command do
  before do
    MCLI::CommandGroup.clear
    expect(MCLI::CommandGroup.commands.empty?).to eq true
  end

  context 'description' do
    before do
      Class.new(MCLI::Command) do
        register_as :test
        description 'This is a test'

        def run
          puts self.class.description
        end
      end
    end

    it 'allows adding a description' do
      set_argv 'test'
      expect { MCLI.run }
        .to output("This is a test\n")
        .to_stdout_from_any_process
    end
  end
end
