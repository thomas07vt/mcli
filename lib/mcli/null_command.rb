class MCLI::NullCommand < MCLI::Command
  option :version, alias: 'v', boolean: true

  def run
    if options[:version]
      puts MCLI::VERSION
    else
      help
    end
  end

  def help
    puts help_message
  end

  def help_message
    "No command passed\n#{parser.to_s}"
  end
end
