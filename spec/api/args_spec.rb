require 'spec_helper'

describe MCLI::Command do
  before do
    MCLI::CommandGroup.clear
    expect(MCLI::CommandGroup.commands.empty?).to eq true
  end

  context 'args' do
    before do
      Class.new(MCLI::Command) do
        register_as :test

        def run
          puts args
        end
      end
    end

    it 'is supported' do
      set_argv "test one two"
      expect { MCLI.run }
        .to output("one\ntwo\n")
        .to_stdout_from_any_process
    end
  end

  context 'args with options' do
    before do
      Class.new(MCLI::Command) do
        register_as :test
        option :option, alias: 'a'

        def run
          puts args
        end
      end
    end

    it 'is supported' do
      set_argv "test one -a option two"
      expect { MCLI.run }
        .to output("one\ntwo\n")
        .to_stdout_from_any_process
    end
  end
end

