require 'spec_helper'

describe MCLI::Command do
  before do
    MCLI::CommandGroup.clear
    expect(MCLI::CommandGroup.commands.empty?).to eq true
  end

  context 'root command' do
    before do
      Class.new(MCLI::Command) do
        register_as_root
        option 'root', alias: 'r'

        def run
          puts args
          puts options[:root]
        end
      end
    end

    it 'is supported' do
      set_argv "one two -r three"
      expect { MCLI.run }
        .to output("one\ntwo\nthree\n")
        .to_stdout_from_any_process
    end
  end
end
