require 'spec_helper'

describe MCLI::Command do
  before do
    MCLI::CommandGroup.clear
    expect(MCLI::CommandGroup.commands.empty?).to eq true
  end

  context 'capture_all!' do
    before do
      Class.new(MCLI::Command) do
        register_as :test
        capture_all!

        def run
          puts args
        end
      end
    end

    it 'is supported' do
      set_argv "test one two -a ok --toast=yes"
      expect { MCLI.run }
        .to output("one\ntwo\n-a\nok\n--toast=yes\n")
        .to_stdout_from_any_process
    end
  end
end
