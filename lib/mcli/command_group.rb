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
  end
end

