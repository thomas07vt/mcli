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

    parser.parse!(@args)

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
      parser.program_name = self.class.command_name

      parser.on("-h", "--help", "Help") do
        raise MCLI::HelpError.new
      end
    end
  end

  class << self
    def description(desc=nil)
      @description = desc unless desc.nil?
      @description ||= ''
    end

    def option(option_name, opts={})
      options << Option.new(option_name, opts)
    end

    def options
      @options ||= []
    end

    def register_as(command_name, to: default_command_group)
      @command_name = command_name
      to.register(command_name, self)
    end

    def register_as_root(to: default_command_group)
      to.register_root(self)
    end

    def capture_all!
      @capture_all = true
    end

    def capture_all?
      @capture_all
    end

    def command_name
      @command_name
    end

    def default_command_group
      MCLI::CommandGroup
    end

    def call(args)
      new(args).tap do |command|
        begin
          command.parse unless capture_all?
          command.run
        rescue MCLI::HelpError
          command.help
        end
      end
    end
  end
end

