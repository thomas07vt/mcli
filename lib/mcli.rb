require 'optparse'
require 'mcli/version'
require 'mcli/help_error'
require 'mcli/command_group'
require 'mcli/command'
require 'mcli/command/option'
require 'mcli/null_command'

module MCLI
  class << self
    def run
      CommandGroup.call(ARGV.dup)
    end
  end
end
