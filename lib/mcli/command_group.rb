class MCLI::CommandGroup
  class << self
    def register(command_name, command_klass)
      commands[command_name] = command_klass
    end

    def commands
      @commands ||= {}
    end

    def clear
      @commands = {}
    end
  end
end

