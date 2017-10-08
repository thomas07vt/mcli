class MCLI::NullCommand < MCLI::Command
  option :version, alias: 'v', boolean: true

  def run
    if options[:version]
      puts MCLI::VERSION
    else
      self.class.help
    end
  end

  class << self
    def help
      puts help_message
    end

    def help_message
      'No command passed'
    end
  end
end
