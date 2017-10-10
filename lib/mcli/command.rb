class MCLI::Command
  attr_reader :args

  def initialize(args=[])
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

    self.class.options
      .select { |option| option.required == true }
      .map do |required_option|
        if @options[required_option.name].nil?
          raise OptionParser::MissingArgument
        end
      end
  end

  def options
    @options ||= {}
  end

  def parser
    @parser ||= create_parser
  end

  def create_parser
    OptionParser.new.tap do |parser|
      parser.on("-h", "--help", "Help") do
        raise MCLI::HelpError.new
      end
    end
  end

  class << self
    def option(option_name, opts={})
      options << Option.new(option_name, opts)
    end

    def options
      @options ||= []
    end

    def register_as(command_name)
      MCLI::CommandGroup.register(command_name, self)
    end

    def call
      new(ARGV).tap do |command|
        begin
          command.parse
          command.run
        rescue MCLI::HelpError
          command.help
        end
      end
    end
  end
end

