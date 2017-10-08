require 'spec_helper'

describe MCLI::NullCommand do
  describe '#run' do
    it 'returns a help message' do
      expect { MCLI::NullCommand.new.run }
        .to output("#{MCLI::NullCommand.help_message}\n")
        .to_stdout_from_any_process
    end
  end
end

