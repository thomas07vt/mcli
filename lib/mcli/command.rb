class MCLI::Command
  class << self
    def option(option_name, opts={})
      options << Option.new(option_name, opts)
    end

    def options
      @options ||= []
    end

    def find_option(option_name)
      options.find { |o| o.name == option_name }
    end

    def register_as(command_name)
      MCLI::CommandGroup.register(command_name, self)
    end
  end
end

