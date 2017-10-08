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
      command = ARGV.shift

      CommandGroup.commands.fetch(command.to_s.to_sym) do |command|
        ARGV.unshift(command)
        NullCommand
      end.call
    end
  end
end
