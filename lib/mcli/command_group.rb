class MCLI::CommandGroup
  class << self
    def register(command_name, command_klass)
      commands[command_name] = command_klass
    end

    def register_root(command_klass)
      @root_command = command_klass
    end

    def commands
      @commands ||= {}
    end

    def clear
      @commands = {}
    end

    def root_command
      @root_command
    end

    def call(args)
      command = args.shift

      commands.fetch(command.to_s.to_sym) do |command|
        args.unshift(command)
        root_command || MCLI::NullCommand
      end.call(args)
    end
  end
end

