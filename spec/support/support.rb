module Support
  def set_argv(args)
    ARGV.clear
    ARGV << args
    ARGV.flatten!
  end
end
