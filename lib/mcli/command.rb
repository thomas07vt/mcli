class MCLI::Command
  class << self
    def option(name, opts={})
      options << Option.new(name, opts)
    end

    def options
      @options ||= []
    end

    def find_option(name)
      options.find { |o| o.name == name }
    end
  end
end

