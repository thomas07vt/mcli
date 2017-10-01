class MCLI::Command
  def initialize(args)
    @args = args
  end

  def parse
    @options = {}

    self.class.options.each do |option|
      @options[option.name] = option.default if option.default

      parser.on(*option.to_args) do |o|
        @options[option.name] = o
      end
    end

    parser.parse!
  end

  def parser
    @parser ||= OptionParser.new
  end

  def options
    @options
  end

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

    def call
      new(ARGV).tap do |command|
        command.parse
        command.run
      end
    end
  end
end

