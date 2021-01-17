require 'spec_helper'

describe MCLI::Command do
  before do
    MCLI::CommandGroup.clear
    expect(MCLI::CommandGroup.commands.empty?).to eq true
  end

  context 'nested commands' do
    before do
      group_command = Class.new(MCLI::Command) do
        register_as :group
        capture_all!

        def run
          self.class.group.call(args)
        end

        def self.group
          @group ||= Class.new(MCLI::CommandGroup)
        end
      end

      Class.new(MCLI::Command) do
        register_as :nested, to: group_command.group
        option :works

        def run
          puts options[:works]
        end
      end
    end

    it 'is supported through groups' do
      set_argv "group nested --works success"
      expect { MCLI.run }
        .to output("success\n")
        .to_stdout_from_any_process
    end
  end
end
