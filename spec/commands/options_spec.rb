require 'spec_helper'

describe MCLI::Command do
  before do
    MCLI::CommandGroup.clear
    expect(MCLI::CommandGroup.commands.empty?).to eq true
  end

  context 'options with aliases' do
    before do
      Class.new(MCLI::Command) do
        register_as :test
        option :alias, alias: 'a'

        def run
          puts options[:alias]
        end
      end
    end

    it 'is supported' do
      set_argv ['test', '-a success']
      expect { MCLI.run }
        .to output("success\n")
        .to_stdout_from_any_process
    end

    it 'supports the full option flag' do
      set_argv ['test', '--alias success']
      expect { MCLI.run }
        .to output("success\n")
        .to_stdout_from_any_process
    end
  end
end


