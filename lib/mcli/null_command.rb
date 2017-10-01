class MCLI::NullCommand < MCLI::Command
  def run
    self.class.help
  end

  class << self
    def help
      puts 'No command passed'
    end
  end
end
