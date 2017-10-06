module Support
  def set_argv(args)
    ARGV.clear
    ARGV << args.split(' ')
    ARGV.flatten!
  end
end
