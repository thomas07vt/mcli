require 'spec_helper'

# This test using aruba and actualy makes a call out the bin/mcli
# For some reason simplecov doesn't see this test so I need to duplicate the
# test for 100% test coverage
RSpec.describe MCLI do
  it 'has a version number' do
    expect(MCLI::VERSION).not_to be nil
  end

  context 'no args' do
    it 'prints help' do
      expect { MCLI.run }
        .to output(MCLI::NullCommand.new.tap(&:parse).help_message)
        .to_stdout_from_any_process
    end
  end

  context '--version ' do
    it 'prints the version' do
      set_argv '--version'
      expect { MCLI.run }
        .to output("#{MCLI::VERSION}\n")
        .to_stdout_from_any_process
    end
  end

  context '-v ' do
    it 'prints the version' do
      set_argv '-v'
      expect { MCLI.run }
        .to output("#{MCLI::VERSION}\n")
        .to_stdout_from_any_process
    end
  end

  context '--help' do
    it 'prints help' do
      set_argv '--help'
      expect { MCLI.run }
        .to output(MCLI::NullCommand.call.help_message)
        .to_stdout_from_any_process
    end
  end

  context '-h' do
    it 'prints help' do
      set_argv '-h'
      expect { MCLI.run }
        .to output(MCLI::NullCommand.call.help_message)
        .to_stdout_from_any_process
    end
  end
end
